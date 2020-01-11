Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4C9137B53
	for <lists+linux-edac@lfdr.de>; Sat, 11 Jan 2020 04:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgAKD5d (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 Jan 2020 22:57:33 -0500
Received: from mail-dm6nam11on2041.outbound.protection.outlook.com ([40.107.223.41]:21498
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728243AbgAKD5d (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 10 Jan 2020 22:57:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5wvNuw9eJl9eI6Q/oeqBYMkwBHbsXHdTScZtP2kN9gEbTNOnnrDZMv2S+vRKrAv03CmarM2O7J9YnLu3byVyw2XlfJuM8Lafh2whU7XuZs/jiFPlsa03jW62YVrV03CHVeYNp2dOZbziISGyg2r52foDxlyh7Tm56CMixuZZnvj0eLWewafCQBDWftJgCBvXPZgDhpQm8AVsRsmvs7MuKN/Klk2ZwVNkqSP9sR4IWLe8xZNZ7QRgPp7gdxa09VNapdWYsyRDbiSzwRxlMFCbUSTeaqc1JPXlQcntrPAXY67mxOGOm7UXiINBch0pxkkl9dq2c33NwJ9Bh/CJzjY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDgHu8yScAACB31qoDwmYnBppMkg5oPumfVdTWX1/SY=;
 b=EA5cwPYV/mAZ+v8bu0sr62Pcs1rT8R0npLkw9GA1q9GgcC+vkQNCCElX5d2la/G6ENQzpf4OCir0q+BiToxa+mZUkQYCCZ1NWUTpFo/5Z19CVzVOGL8YBDycKV9yEtP6iu+1VEOmkFBUdbDHVHXTPZy86gFXrFD+xSP8O/xJNVj2rYep7S+nyyJja4rd9t6PSQlLkVwbPKvhOsAB62TgdWZJCPRnVTyRe3QoSxtCFNWYW8jIo73WL74XO1Uo2seUuQeZm6sW6Ml/X9NbyKJIywlNl3P66EhN126XWT+ma9N1O3z0NSHLgxDT3DXABXFcQhHYNzX5uWJPxWR5lCM3pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDgHu8yScAACB31qoDwmYnBppMkg5oPumfVdTWX1/SY=;
 b=G0Okwd4HgfYsohTlv0aNiXMpTCy2KzuBrYhYLO7XG2JT/U5svrAJTP4BxbT4qLBuX/7YWB9ahNBp1PfvCdWlkR3wOzcjvYSpdDmhyAy86NuDQd6I6BeiBfUefeEXWa50ZnC3TWuiPEfrQbzF29xwyQA62KFDnuYUnouoS4lG1sU=
Received: from CH2PR13MB3368.namprd13.prod.outlook.com (52.132.246.90) by
 CH2PR13MB3590.namprd13.prod.outlook.com (52.132.246.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.10; Sat, 11 Jan 2020 03:57:26 +0000
Received: from CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5]) by CH2PR13MB3368.namprd13.prod.outlook.com
 ([fe80::eccb:16ac:e897:85d5%3]) with mapi id 15.20.2644.012; Sat, 11 Jan 2020
 03:57:26 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>
CC:     "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH] riscv: move sifive_l2_cache.h to include/soc
Thread-Topic: [PATCH] riscv: move sifive_l2_cache.h to include/soc
Thread-Index: AQHVxeorDALZ3QQDdE2BsC6QnTnA3KfkqnIAgAAL4gCAACLh8A==
Date:   Sat, 11 Jan 2020 03:57:25 +0000
Message-ID: <CH2PR13MB3368D2DF7D06BA494AECBE238C3B0@CH2PR13MB3368.namprd13.prod.outlook.com>
References: <1578463746-25279-1-git-send-email-yash.shah@sifive.com>
 <alpine.DEB.2.21.9999.2001101704440.32308@viisi.sifive.com>
 <alpine.DEB.2.21.9999.2001101746310.40553@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.2001101746310.40553@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yash.shah@sifive.com; 
x-originating-ip: [114.143.65.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d41a66f8-3fbf-43be-e724-08d7964a5f0f
x-ms-traffictypediagnostic: CH2PR13MB3590:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR13MB359086FF07B92FC5AC7680958C3B0@CH2PR13MB3590.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0279B3DD0D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(396003)(346002)(136003)(366004)(376002)(189003)(199004)(2906002)(44832011)(9686003)(8676002)(55016002)(81156014)(81166006)(86362001)(53546011)(6506007)(7696005)(33656002)(7416002)(6636002)(71200400001)(186003)(26005)(6862004)(5660300002)(316002)(8936002)(54906003)(76116006)(66946007)(66476007)(66446008)(66556008)(64756008)(52536014)(478600001)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR13MB3590;H:CH2PR13MB3368.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: sifive.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PjZCvxFw3iugPFKaxKc1yDjt7OZfoWTcT/mg5M7NknV4yEonF9vROyMc7a9Nnkiqy9SQZvc4cDBp+2E/Q1Azm3OSyMvrUyy7eu/Rk08IeQ2ANkKc7IOy+q5jj3oYQObZdWM9W8rosfQyxBtpV9QZIGKiVA3w74iogTXZ2TFjl5RBdyPb1yB0FFSgOFTfOGanln4E1+8Y5HGimBeOP+cWS2w0FTp8261Rsq+3uBmK15kPoi3/QtHu2iThyUIuz4zL3ew76zSyIhDSozl2/AjS6z1UpGwwbp9ytRslwbDgKNGjeTM1i0MUWa6BoL0BRa8ZKDiRh8jo1tf43CzDO3KydZtq5d+Bdq3SYDRLvNRQ06CtmtaEPbJnRBlNOiZtAaAVx5Iw2KXYfGcZCFx8TKOEvqkG6su0nYqPR0EUXbfuYrfizGXJqctuAnzBfdzA4GFH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41a66f8-3fbf-43be-e724-08d7964a5f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2020 03:57:25.7011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+OP+VEZjDHzOQObiN8lFsh/85yxU+EZpa3jHPsN/MDMHkLlssqfPJF6xIrsti2c0HcDfWeqQLS+DYUIy1VGWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3590
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



> -----Original Message-----
> From: Paul Walmsley <paul.walmsley@sifive.com>
> Sent: 11 January 2020 07:17
> To: Yash Shah <yash.shah@sifive.com>
> Cc: palmer@dabbelt.com; aou@eecs.berkeley.edu; bp@alien8.de;
> mchehab@kernel.org; tony.luck@intel.com; james.morse@arm.com;
> rrichter@marvell.com; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-edac@vger.kernel.org
> Subject: Re: [PATCH] riscv: move sifive_l2_cache.h to include/soc
>=20
> On Fri, 10 Jan 2020, Paul Walmsley wrote:
>=20
> > On Tue, 7 Jan 2020, Yash Shah wrote:
> >
> > > The commit 9209fb51896f ("riscv: move sifive_l2_cache.c to
> > > drivers/soc") moves the sifive L2 cache driver to driver/soc. It did
> > > not move the header file along with the driver. Therefore this patch
> > > moves the header file to driver/soc
> > >
> > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> >
> > Thanks, queued for v5.5-rc.
>=20
> By the way, I fixed the include guard also.  The queued patch follows.

Thanks, somehow I had overseen that.

- Yash

>=20
>=20
> - Paul
>=20
> From: Yash Shah <yash.shah@sifive.com>
> Date: Tue, 7 Jan 2020 22:09:06 -0800
> Subject: [PATCH] riscv: move sifive_l2_cache.h to include/soc
>=20
> The commit 9209fb51896f ("riscv: move sifive_l2_cache.c to drivers/soc")
> moves the sifive L2 cache driver to driver/soc. It did not move the heade=
r file
> along with the driver. Therefore this patch moves the header file to
> driver/soc
>=20
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> [paul.walmsley@sifive.com: updated to fix the include guard]
> Fixes: 9209fb51896f ("riscv: move sifive_l2_cache.c to drivers/soc")
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>  drivers/edac/sifive_edac.c                                  | 2 +-
>  drivers/soc/sifive/sifive_l2_cache.c                        | 2 +-
>  .../include/asm =3D> include/soc/sifive}/sifive_l2_cache.h    | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)  rename
> {arch/riscv/include/asm =3D> include/soc/sifive}/sifive_l2_cache.h (72%)
>=20
> diff --git a/drivers/edac/sifive_edac.c b/drivers/edac/sifive_edac.c inde=
x
> 413cdb4a591d..c0cc72a3b2be 100644
> --- a/drivers/edac/sifive_edac.c
> +++ b/drivers/edac/sifive_edac.c
> @@ -10,7 +10,7 @@
>  #include <linux/edac.h>
>  #include <linux/platform_device.h>
>  #include "edac_module.h"
> -#include <asm/sifive_l2_cache.h>
> +#include <soc/sifive/sifive_l2_cache.h>
>=20
>  #define DRVNAME "sifive_edac"
>=20
> diff --git a/drivers/soc/sifive/sifive_l2_cache.c
> b/drivers/soc/sifive/sifive_l2_cache.c
> index a9ffff3277c7..a5069394cd61 100644
> --- a/drivers/soc/sifive/sifive_l2_cache.c
> +++ b/drivers/soc/sifive/sifive_l2_cache.c
> @@ -9,7 +9,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_address.h>
> -#include <asm/sifive_l2_cache.h>
> +#include <soc/sifive/sifive_l2_cache.h>
>=20
>  #define SIFIVE_L2_DIRECCFIX_LOW 0x100
>  #define SIFIVE_L2_DIRECCFIX_HIGH 0x104
> diff --git a/arch/riscv/include/asm/sifive_l2_cache.h
> b/include/soc/sifive/sifive_l2_cache.h
> similarity index 72%
> rename from arch/riscv/include/asm/sifive_l2_cache.h
> rename to include/soc/sifive/sifive_l2_cache.h
> index 04f6748fc50b..92ade10ed67e 100644
> --- a/arch/riscv/include/asm/sifive_l2_cache.h
> +++ b/include/soc/sifive/sifive_l2_cache.h
> @@ -4,8 +4,8 @@
>   *
>   */
>=20
> -#ifndef _ASM_RISCV_SIFIVE_L2_CACHE_H
> -#define _ASM_RISCV_SIFIVE_L2_CACHE_H
> +#ifndef __SOC_SIFIVE_L2_CACHE_H
> +#define __SOC_SIFIVE_L2_CACHE_H
>=20
>  extern int register_sifive_l2_error_notifier(struct notifier_block *nb);=
  extern
> int unregister_sifive_l2_error_notifier(struct notifier_block *nb); @@ -1=
3,4
> +13,4 @@ extern int unregister_sifive_l2_error_notifier(struct notifier_b=
lock
> *nb);  #define SIFIVE_L2_ERR_TYPE_CE 0  #define SIFIVE_L2_ERR_TYPE_UE 1
>=20
> -#endif /* _ASM_RISCV_SIFIVE_L2_CACHE_H */
> +#endif /* __SOC_SIFIVE_L2_CACHE_H */
> --
> 2.25.0.rc2
>=20
>=20

