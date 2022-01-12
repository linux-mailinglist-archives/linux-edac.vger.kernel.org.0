Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A0B48C92E
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jan 2022 18:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348473AbiALRTX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Jan 2022 12:19:23 -0500
Received: from mail-centralusazon11021025.outbound.protection.outlook.com ([52.101.62.25]:45895
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348434AbiALRTW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 Jan 2022 12:19:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1qkF68+hJMTGw1nHyLQWZjSeIZ4xnNuE4RfAF4SnxlTr9tryUMg1f3N+WrV43j4u7cjuwhrk0T9sFQ3k+mzoowlO6CXnbXxtbEuqJVm7sC5SfpypxV9nx6EHNAVrP2q9o9StZIkywaFgYCAaSeWqngZ1tlA1BcU9zec3QbmlGqXfJTSwe0I7pi7AT3w06RStIq4Tm5CXZuPUG/EYFelGjJ81Q4qeAb/gtfldF7dI22++rklEK6z3D8Qt7vdRI1ngrJ7ng/uIpRjyQW2B9RufL8lsrVuaa6PWwpPoNMq25NbpZV/qdMYmXG5D5A9gu70dAuNwenZKRjz/t+1wZsd2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KvCwWtuiDrhvnsGHA7KkSUDN4yekN4aCKr9Lbt3sX4=;
 b=ny3exe5TjDJnJy4FxG3OCo66EZ1H7+l/tgFpadyDX9UOtDEHIv/5zX7gL9wPJu4u6CpNe0vmdwgDIlOlujJaHcyqlq48oJv325McfkyimGltBK0Yx+wUo6podAGGyIPg1dv87u7Dwoe7nQeFNtX5ZSmiCniXGzrr4WdYEDB9zJ6+BtOvQ0DzFLpNZsLaW0yLMQPZx3OUgcfOtTl9Tsx9UUXfFcTSR+g2XoQyljHIyVO1AGf3JLk1re8fliVO5K3xm/I1CJMMoK1Sud8LTkEsg3/3kHGvMMIjaHgc+V4jrypl7pdagvk2jTdOd7KTu0UqVCAgGcsHWscmY5NWycunQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KvCwWtuiDrhvnsGHA7KkSUDN4yekN4aCKr9Lbt3sX4=;
 b=C0G2WClETfCI3ofBB36JpykfKyQy2Ld6GpD1tr9Ls6yNEeyezWe3RuEes53pNt4aLs5vlVPi/AWJAobK9OBoLURFAgdh+Bu5Tii6KUs+MoB6Y56FKiQ76zi3FHNm9omI3qJ0nEs9e9iAQzwxCxZ63lpO2ZZaIsJsQDtQJcQwf0w=
Received: from PH0PR21MB1992.namprd21.prod.outlook.com (2603:10b6:510:1f::14)
 by DM6PR21MB1740.namprd21.prod.outlook.com (2603:10b6:5:c4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.1; Wed, 12 Jan
 2022 17:19:13 +0000
Received: from PH0PR21MB1992.namprd21.prod.outlook.com
 ([fe80::b0ac:3599:b5fb:2940]) by PH0PR21MB1992.namprd21.prod.outlook.com
 ([fe80::b0ac:3599:b5fb:2940%7]) with mapi id 15.20.4909.002; Wed, 12 Jan 2022
 17:19:13 +0000
From:   "Lei Wang (DPLAT)" <Wang.Lei@microsoft.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Sinan Kaya <okaya@kernel.org>,
        Shiping Ji <shiping.linux@gmail.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/dmc520: Don't print an error for each unconfigured
 interrupt line
Thread-Topic: [PATCH] EDAC/dmc520: Don't print an error for each unconfigured
 interrupt line
Thread-Index: AQHYBwmfLxnRA7SLjEKF6xIo8wH/vqxfoj3w
Date:   Wed, 12 Jan 2022 17:19:13 +0000
Message-ID: <PH0PR21MB19920332C44C677C5A63DB9890529@PH0PR21MB1992.namprd21.prod.outlook.com>
References: <20220111163800.22362-1-tyhicks@linux.microsoft.com>
In-Reply-To: <20220111163800.22362-1-tyhicks@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=42c2043b-2120-42e6-9c60-269547dd3a24;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-12T17:16:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 272528f0-c44d-45d3-1f02-08d9d5efa768
x-ms-traffictypediagnostic: DM6PR21MB1740:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM6PR21MB174076342E9677DF7C12E79390529@DM6PR21MB1740.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kiIH3Etlnc6lMlCCnWYwIY8o9x9K+D53qg4aFuDfzvkjbmLnZO4LsfH1DB2BPa7dhxgQC77qRWJNsFmpt1PpZcmWLSzyH3Sy5M+ttjdLOYbZ/4ElC44ylVUxFh2v+lxyPXxZEkDYKxu1pQCXNYdmV7Fo3uPbT97TTeLUUJ7sOCLxmigk35mdOGL0pWgQGWSXbty4Z1V3ZcLH7e8lGTOZliWnhBaW/pbDHFv9mR2Mj7ue27XJoxORPWxLGpsuBF5g+VWst6PuRdvC7STmGHzyz1h6hhkPE8NmHlaafRCKFPvIRX3xZHYZa9QAROjkZOLr6HyKs2HrFuDot8u3t19nnbl7QzOiHuBUJ5GL4xafR/ASYL7VccjwDRKqbGVDiGItfUNzG2n9+qqLxu2tHOqCpuYgzbfCDNoDb7I2vAQpu3LRBPL8cX68cWfE2Yb0vrpEh1t/bgYtUQVxOTSfD5099ajbEp3af3KyCMMB0dC0rewygEly0ljEDn52s5dIs5yVFwkV3FGC6krBpre+9O4b+4rkp4OI/1KLgPOVdLfNoU3fk5Jie1kaAoDOQW0Pz3wG55e62DgSDWP+FXF8ZAkB219EEhByl9A26YNrk3Zc02oBPozHgLDl0QUYx1BJDVdWh8Bh5q8jA1HinV9agjKKrsq80ayGGq0yOBHAitiDV95lZvTT0Nh1R2z1FpFV6tltFAGB+irE04RUaykteYTXzzr3/OVS5rZnJvHx9OrNJ2fyNsWYsAXZZI6R5K0FLdvi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB1992.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(83380400001)(316002)(64756008)(508600001)(66476007)(38100700002)(66446008)(76116006)(8676002)(71200400001)(4326008)(186003)(110136005)(66556008)(9686003)(53546011)(7696005)(55016003)(5660300002)(8936002)(6506007)(7416002)(52536014)(122000001)(54906003)(38070700005)(33656002)(82950400001)(86362001)(8990500004)(82960400001)(10290500003)(2906002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jvYBNDVjBi7gq0Xj+Q97HSPnGaTAjVyvzUIYIakj2NlUf+7Wxs2uVXKV9Vq9?=
 =?us-ascii?Q?/+oo0loynR/PuwC7gpOTQQ179EgQ0jCS2k1CzKvSAh3B63itnuZLmrz0X2+c?=
 =?us-ascii?Q?P8y+30wX3298DTtfNHlre6rTre3YtupcimNrTHq1HdbiQ24GsYU4seJ8yS3K?=
 =?us-ascii?Q?PHO9oEWadO3sIu88AKizXtH+837MQhoWkk5/JPzvpnzUytEDgVymKgzc48nr?=
 =?us-ascii?Q?f09vkrSwRHYml8UmcbQXTdnz9J0bcOWxw6yz4T0NSF8xqSnCBMfZpjCLJ5Ga?=
 =?us-ascii?Q?5Eiy6ZxXW7izgr9awIcZWERap+7Fjj3EWnrqGJCxOBE3siiRpmkP6RYnMZ3a?=
 =?us-ascii?Q?mTjajY/V1V2nd6AHg8xQrilkSRl49VDc4QzBYsI8FrMBYIHqIAbefNrzS7Y4?=
 =?us-ascii?Q?pO9aI60PaDSlbDxZqaoi62KeZkiiUCoECmFDTIKn8UfUQb8ZxwVhD/6FgKX4?=
 =?us-ascii?Q?FLt1X4xRvBfHjZCtiW7gAKmP6f5GcFaDsi5SyK5eUiHYZWbic6a5EV/TAnrc?=
 =?us-ascii?Q?+Y4IOpHHoc0/nfHIqdhnDZ94aLsBXS1XTTayWov1vXJEPcgRGpbp5cBqpA4v?=
 =?us-ascii?Q?KxZCDIfy0EXqx/zHPkBAYEtEwJNrNksLT73cbIvVG62rC1rmrXc0/V+FURvs?=
 =?us-ascii?Q?mH30tt1ehkFP6/MZOqBCHGY+0Cy1QPHVWT8ags/nM+WpeV86MS/PT/Ndcaqt?=
 =?us-ascii?Q?vPNGl9o0y+6S9nOrQNZZovJBhurZgSjqoAD4K7puY0TpHS/k+KAyF2nIBA+w?=
 =?us-ascii?Q?hK2f1x6vZg3F4djv9/I6Opwmqjhpne1k5xo/Sb+A5YuYHo1eHcyTSbU0Tl8g?=
 =?us-ascii?Q?fJIB+oKhS8txF0TTs2XenVaXQyInbaOZKmnpdYmTPRGsUUxOELcgMQLNGW7L?=
 =?us-ascii?Q?630HYotMhe2FHsl0NabNINr/db1xEAreog6+fzRjUwD317GnsuM1ol0c5Juv?=
 =?us-ascii?Q?cSY2NPaMxMlJadJfht7gYnFD1NcEZ4Ja6yk4wEjYqFlMxvW5U9Qr44/wbcN0?=
 =?us-ascii?Q?cWQMZqxT73w6lsTP4+pARxLrBtDr7rQyTztWuGHVM60AdiacYF4LbqOHwHGH?=
 =?us-ascii?Q?sg+NhBAh1MjZ7SVPkUN9zzGXy+ZoPsaUFNZgkcuudMcybczzhwJtLjyNnDVb?=
 =?us-ascii?Q?IoZyrSe8lwtaDmwj0lUQGKk2yrRawt1FOAcuLvxScBiPnc+qD99wLAUtwTeN?=
 =?us-ascii?Q?bZxHtLet5NawMyoxpF+rWJsGLKtctb7kuW8WQFymiBAcHWmYVrEImGOH7bNj?=
 =?us-ascii?Q?3qYm+o2xQ/jJr+Tfw/ISoZ1solHa5v62zvMErMGmQxsMq4b1kzOe14kONizy?=
 =?us-ascii?Q?SfOr1PlZtHvazfLG0Zn612NDUczleEUfbCylwe2+v/D4CF9s5Hle4gyCEIpl?=
 =?us-ascii?Q?hEMROHkBNPHM2F43CEczTZ4EFlniA+n5VgV7UkWJBqKqFIUhgpI/RJr1hyI+?=
 =?us-ascii?Q?b4WyOdOtnk6gc+WVKHxNDK/e8ZTqmg+6ejHdrAdn1NQ26Yh73wZqGg+Nt2G3?=
 =?us-ascii?Q?mkAopxT88KWhw9kEnymfHEeaQiV/DIc6RYJDBiKdeypJ1GI8DyJ5HodM8zXj?=
 =?us-ascii?Q?sCY3kmGJXj1mJPIqVGJBmT0UDuE0+9dCZNgS9H4eTEoHOnb2qDQsNv5cPTGp?=
 =?us-ascii?Q?6EPSPv74dEoBKvR5x7zPt7J+HFk9jv7z31H4C3EGr04+Q3M/L3HyGBidm93F?=
 =?us-ascii?Q?DRYmmg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB1992.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272528f0-c44d-45d3-1f02-08d9d5efa768
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 17:19:13.1605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lW9NnUpcxRmj4T4Hx0roGo6UwaK0UxRD4hMq5yz9tECuxAE4A9/4PnWZfJ8n7t5C0MzMzxDc14Qc/uPeGaHwrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1740
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> -----Original Message-----
> From: Tyler Hicks <tyhicks@linux.microsoft.com>
> Sent: Tuesday, January 11, 2022 8:38 AM
> To: Lei Wang (DPLAT) <Wang.Lei@microsoft.com>; Borislav Petkov
> <bp@alien8.de>; Tony Luck <tony.luck@intel.com>; Mauro Carvalho Chehab
> <mchehab@kernel.org>
> Cc: Sinan Kaya <okaya@kernel.org>; Shiping Ji <shiping.linux@gmail.com>;
> James Morse <james.morse@arm.com>; Robert Richter <rric@kernel.org>;
> linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] EDAC/dmc520: Don't print an error for each unconfigured
> interrupt line
>=20
> The dmc520 driver requires that at least one interrupt line, out of the t=
en
> possible, is configured. The driver prints an error and returns -EINVAL f=
rom
> its .probe function if there are no interrupt lines configured.
>=20
> Don't print a KERN_ERR level message for each interrupt line that's
> unconfigured as that can confuse users into thinking that there is an err=
or
> condition.
>=20
> Before this change, the following KERN_ERR level messages would be report=
ed
> if only dram_ecc_errc and dram_ecc_errd were configured in the device tre=
e:
>=20
>  dmc520 68000000.dmc: IRQ ram_ecc_errc not found
>  dmc520 68000000.dmc: IRQ ram_ecc_errd not found
>  dmc520 68000000.dmc: IRQ failed_access not found
>  dmc520 68000000.dmc: IRQ failed_prog not found
>  dmc520 68000000.dmc: IRQ link_err not
>  dmc520 68000000.dmc: IRQ temperature_event not found
>  dmc520 68000000.dmc: IRQ arch_fsm not found
>  dmc520 68000000.dmc: IRQ phy_request not found
>=20
> Fixes: 1088750d7839 ("EDAC: Add EDAC driver for DMC520")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Looks good. EDAC-CORE maintainers, please take the patch through your tree.=
=20
Thanks!

Acked-by: Lei Wang <lewan@microsoft.com>

> Cc: <stable@vger.kernel.org>
> Reported-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/edac/dmc520_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c inde=
x
> b8a7d9594afd..1fa5ca57e9ec 100644
> --- a/drivers/edac/dmc520_edac.c
> +++ b/drivers/edac/dmc520_edac.c
> @@ -489,7 +489,7 @@ static int dmc520_edac_probe(struct platform_device
> *pdev)
>  	dev =3D &pdev->dev;
>=20
>  	for (idx =3D 0; idx < NUMBER_OF_IRQS; idx++) {
> -		irq =3D platform_get_irq_byname(pdev,
> dmc520_irq_configs[idx].name);
> +		irq =3D platform_get_irq_byname_optional(pdev,
> +dmc520_irq_configs[idx].name);
>  		irqs[idx] =3D irq;
>  		masks[idx] =3D dmc520_irq_configs[idx].mask;
>  		if (irq >=3D 0) {
> --
> 2.25.1

