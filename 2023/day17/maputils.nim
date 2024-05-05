type
    Position* = tuple
        x: int
        y: int

type
    Direction* = enum
        ABOVE = 0,
        RIGHT,
        BELOW,
        LEFT,

var x_max: int = 0
var y_max: int = 0

##########

proc getXMax*(): int =
    result = x_max

proc setXMax*(x: int): void =
    x_max = x

proc getYMax*(): int =
    result = y_max

proc setYMax*(y: int): void =
    y_max = y

proc getAbovePosition(p: Position): Position =
    result = p
    if p.y > 0:
        result = (p.x, p.y - 1)

proc getBelowPosition(p: Position): Position =
    result = p
    if p.y < getYMax():
        result = (p.x, p.y + 1)

proc getRightPosition(p: Position): Position =
    result = p
    if p.x < getXMax():
        result = (p.x + 1, p.y)

proc getLeftPosition(p: Position): Position =
    result = p
    if p.x > 0:
        result = (p.x - 1, p.y)

proc getNeighbors*(p: Position): seq[Position] =
    result = @[]
    # Above
    let above = getAbovePosition(p)
    if p != above:
        result.add(above)
    # Right
    let right = getRightPosition(p)
    if p != right:
        result.add(right)
    # Left
    let below = getBelowPosition(p)
    if p != below:
        result.add(below)
    # Below
    let left = getLeftPosition(p)
    if p != left:
        result.add(left)
    # echo p, " : ", result

proc getDistance*(p1, p2: Position): int =
    result = abs(p1.x - p2.x) + abs(p1.y - p2.y)

proc getDirection*(pFrom, pTo: Position): Direction =
    if pFrom.x == pTo.x:
        if pFrom.y > pTo.y:
            result = ABOVE
        else:
            result = BELOW
    else:
        if pFrom.x < pTo.x:
            result = RIGHT
        else:
            result = LEFT
    if getDistance(pFrom, pTo) != 1:
        echo "getDirection : Invalid args ", pFrom, " ", pTo

proc oppositeDirection*(d: Direction): Direction =
    case d
    of ABOVE:
        result = BELOW
    of RIGHT:
        result = LEFT
    of BELOW:
        result = ABOVE
    of LEFT:
        result = RIGHT
