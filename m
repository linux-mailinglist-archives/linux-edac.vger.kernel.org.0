Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E108838249
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2019 02:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfFGAr7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jun 2019 20:47:59 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:34373 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfFGAr7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Jun 2019 20:47:59 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id DD1BE886BF;
        Fri,  7 Jun 2019 12:47:55 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1559868475;
        bh=h8GfrivEaJj042vYLp1gJzMOsrQwukxIiCoNK8N8T9s=;
        h=From:To:CC:Subject:Date:References;
        b=r18etF92Ubre9H+ccz6XnvCIPBNCqF1QKY9xST4bnJmQU0Bimo25TWOBUK0dOG7ky
         Bgm70JZS+0pvk9tXCLzrdcKLgJjgVESSLWhbVHZ/d4uUMi+2IjEgdHled7QU6blonc
         +BEnzkO4oeomDWmS6mzwxveagc1+1abdRjB55+90bRCNmhnhRnx6KrrWkvXu7nrVkM
         u0OBrpsXnX+S85XgLl1qjpfswwRTBWJpE67In9FH6hyjoZeA5CgLpY+QVnkhxHbqCm
         j9Oi7ddf8UWeDLNo/nm6D41JoUNJDB6dCyjLnd4IISjTSqcj+RaGhTFkMWp7PkpdfM
         uggLVCXQb+SKg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5cf9b43c0000>; Fri, 07 Jun 2019 12:47:56 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Fri, 7 Jun 2019 12:47:51 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Fri, 7 Jun 2019 12:47:51 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "bp@alien8.de" <bp@alien8.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "jlu@pengutronix.de" <jlu@pengutronix.de>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/9] EDAC drivers for Armada XP L2 and DDR
Thread-Topic: [PATCH v8 0/9] EDAC drivers for Armada XP L2 and DDR
Thread-Index: AQHVBxlTMstd+GrP+EKH5co1CKKfyQ==
Date:   Fri, 7 Jun 2019 00:47:50 +0000
Message-ID: <9d41bbc106b24670a5dfe0993bd54274@svr-chch-ex1.atlnz.lc>
References: <20190510101536.6724-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi All,=0A=
=0A=
On 10/05/19 10:15 PM, Chris Packham wrote:=0A=
> The Reviews/Acks have been given so this should be good to go in via the =
ARM=0A=
> tree as planned.=0A=
> =0A=
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-August/525561.=
html=0A=
> =0A=
> This series adds drivers for the L2 cache and DDR RAM ECC functionality a=
s=0A=
> found on the MV78230/MV78x60 SoCs. Jan has tested these changes with the=
=0A=
> MV78460 (on a custom board with a DDR3 ECC DIMM), Chris has tested these=
=0A=
> changes with 88F6820 and 98dx3236 (both a custom boards with fixed DDR3 +=
 ECC).=0A=
> =0A=
> Also contained in this series is an additional debugfs wrapper.=0A=
=0A=
Ping?=0A=
=0A=
> =0A=
> Compared to the previous v7 series this has been rebased against 5.1 requ=
iring=0A=
> some changes in the devicetree binding documentation.=0A=
> =0A=
> Compared to the previous v6 series I've dropped the marvell,ecc-disable=
=0A=
> property.=0A=
> =0A=
> Compared to the previous v5 series I've split the dt-binding documentatio=
n into=0A=
> its own patch and updated armada_xp_edac.c to use a SPDX license.=0A=
> =0A=
> Compared to the previous v4 series I've added my s-o-b to some of Jan's=
=0A=
> patches and rebased against v4.19.0.=0A=
> =0A=
> Compared to the previous v3 series, the following changes have been made:=
=0A=
> - Use shorter names for the AURORA ECC and parity registers=0A=
> - Numerous formatting changes to edac/armada_xp.c (as requested by Boris)=
=0A=
> - Added support for Armada-38x and 98dx3236 SoCs=0A=
> =0A=
> Compared to the previous v2 series, the following changes have been made:=
=0A=
> - Allocate EDAC structures later during probing and drop devres support=
=0A=
>    patches (requested by Boris)=0A=
> - Make drvdata->width usage consistent according to the comment (suggeste=
d by=0A=
>    Chris)=0A=
> =0A=
> Compared to the previous v1 series, the following changes have been made:=
=0A=
> - Add the aurora-l2 register defines earlier in the series (suggested by=
=0A=
>    Russell King and Gregory CLEMENT )=0A=
> - Changed the DT vendor prefix from "arm" to "marvell" for the ecc-enable=
/disable=0A=
>    properties on the aurora-l2 (suggested by Russell King)=0A=
> - Fix some warnings reported by checkpatch=0A=
> =0A=
> Compared to the original RFC series, the following changes have been made=
:=0A=
> - Integrated Chris' patches for parity and ECC configuration via DT=0A=
> - Merged the DDR RAM and L2 cache drivers (as requested by Boris, analogo=
us=0A=
>    to fsl_ddr_edac.c and mpc85xx_edac.c)=0A=
> - Added myself to MAINTAINERS (requested by Boris)=0A=
> - L2 cache: Track the msg size and use snprintf (review comment by Chris)=
=0A=
> - L2 cache: Split error injection from the check function (review comment=
 by=0A=
>    Chris)=0A=
> - DDR RAM: Allow 16 bit width in addition to 32 and 64 bit (review commen=
t by=0A=
>    Chris)=0A=
> - Use of_match_ptr() (review comments by Chris)=0A=
> - Minor checkpatch cleanups=0A=
> =0A=
> =0A=
> Chris Packham (4):=0A=
>    ARM: l2x0: support parity-enable/disable on aurora=0A=
>    dt-bindings: ARM: document marvell,ecc-enable binding=0A=
>    ARM: l2x0: add marvell,ecc-enable property for aurora=0A=
>    EDAC: armada_xp: Add support for more SoCs=0A=
> =0A=
> Jan Luebbe (5):=0A=
>    ARM: l2c: move cache-aurora-l2.h to asm/hardware=0A=
>    ARM: aurora-l2: add prefix to MAX_RANGE_SIZE=0A=
>    ARM: aurora-l2: add defines for parity and ECC registers=0A=
>    EDAC: Add missing debugfs_create_x32 wrapper=0A=
>    EDAC: Add driver for the Marvell Armada XP SDRAM and L2 cache ECC=0A=
> =0A=
>   .../devicetree/bindings/arm/l2c2x0.yaml       |   4 +=0A=
>   MAINTAINERS                                   |   6 +=0A=
>   .../asm/hardware}/cache-aurora-l2.h           |  50 +-=0A=
>   arch/arm/mm/cache-l2x0.c                      |  18 +-=0A=
>   drivers/edac/Kconfig                          |   7 +=0A=
>   drivers/edac/Makefile                         |   1 +=0A=
>   drivers/edac/armada_xp_edac.c                 | 635 ++++++++++++++++++=
=0A=
>   drivers/edac/debugfs.c                        |  11 +=0A=
>   drivers/edac/edac_module.h                    |   5 +=0A=
>   9 files changed, 733 insertions(+), 4 deletions(-)=0A=
>   rename arch/arm/{mm =3D> include/asm/hardware}/cache-aurora-l2.h (50%)=
=0A=
>   create mode 100644 drivers/edac/armada_xp_edac.c=0A=
> =0A=
=0A=
