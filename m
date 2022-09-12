Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822A05B5361
	for <lists+linux-edac@lfdr.de>; Mon, 12 Sep 2022 07:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiILF0L (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Sep 2022 01:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiILF0K (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Sep 2022 01:26:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0B52408E;
        Sun, 11 Sep 2022 22:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwtEcbiuFK1FVn5CESHtcUmixeiCiWHDRePTZ1KocPvskWRK5iZolI6+TlTwACtlY+l65GarLBROnLoUFfILTgA8T5sjuJPLADF0o/S9doIQqTlNSgsPDMNbEeLkpKLH2jXBtuhJNrVv8yIDglLCdo9Z9kwr9LSLgyPTYZh6+yWXnrq2vYBEEddp+w36Xcm/82G+/itKBP/vNjpZjAgfW1DO7RIxcgEqXKbzvBPhSoHUhVOPbCcku+8HmCseoI3xK61rhVF8GPAUtRzjy5cYXAXANjiDJeAfL2zDwT1X/sJfWDZycVCknFo7i3czeJem075EHKMgRZvp+nwuuuCgvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUhVdrzMs46W+VSbcZhuF/B46Wxu22dGO95JUP4bvqQ=;
 b=MUqDSWdzIFl7N6raLvj8hyG38+9CRL0fVVOliWHc8efYP+1sViDvRtW/ft4+Hl6H3QPkqCvG6LXI2edg2+h6HCE7UxIgyQtbGbpdXeUZRPqpN/eSistJUXRilXkpZAgcUhgODUplwj+wMxrE4WZ5+oasd1DvHGT65Mv3Bx+R4DzZdTRwhI5PycgOxii9O1l7bMgPra4dVzlC7OLGlxGYOh8qAzutbztNMAh2dIfOoUe+wpllmEfWx5o62BgibE0rEAbNgEQzfALKGjVwj4cSv9Vm2B0+xlak1nFkJwNQ52joJrxwwE7P3auNqdBNAlxuu9bEVay9aA0nyPhjLOFEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUhVdrzMs46W+VSbcZhuF/B46Wxu22dGO95JUP4bvqQ=;
 b=i4CTWztKwSCgAM4vVU2J9BEVhBgBtd3xf2M47nhHtPSu4mpFsrbXQ322qFgVz4sNY2GwrMfMMY9dDcIrRyRNCmxpZEVqq9607U6jDPXuYFrXMeO7cQp4vwsLfrBhmnLGXu4eZriwoDQYbXCGBPNQIYCV42x0zVqEY+QetN1PoAU=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Mon, 12 Sep
 2022 05:26:06 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::d56c:9b61:c050:cb6a]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::d56c:9b61:c050:cb6a%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 05:26:06 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: RE: [PATCH v2 05/19] EDAC/synopsys: Fix reading errors count before
 ECC status
Thread-Topic: [PATCH v2 05/19] EDAC/synopsys: Fix reading errors count before
 ECC status
Thread-Index: AQHYxU2SF4wmRzd59UeU6ThIK05n8a3bRP5g
Date:   Mon, 12 Sep 2022 05:26:05 +0000
Message-ID: <BY5PR12MB4902967903EB6FE0306B89D581449@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
 <20220910194237.10142-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220910194237.10142-6-Sergey.Semin@baikalelectronics.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-12T05:26:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=85ef998e-5e29-44ac-9822-356ca28012db;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4902:EE_|BL1PR12MB5128:EE_
x-ms-office365-filtering-correlation-id: 3eef739e-bbcf-4db5-f334-08da947f4a99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EV75c5ahvhs771JfhQUw4O5OCF//6Hjx/cNFOuJ1OFVNaaKgSHmd8CDK826zbfOWlLmzkPYdqE+ud8Og/hZ7rOrwPSJC8WV64yq9oGpUC9vpDVcBXD9/J2nxwtLO8nnHgZaRlHXbrqyESu8x04tCKs5vAWu3dukTTLvnmRAo7SMusR4hNW0OOyfsnZPze3Mfuk7GtyxlJ3ITYwyR9f+r+cdLW8929hmNVKdQWcgJgbWj8qKRSRHdla9GmpE5NytBZ7bNs8EX0n1zgAcDo0giottvsjnhOqaP4JzSnPN+HCVwNdR12VrCi7s6S4Xv5o8qqQk8iE4jAObTcC0ij1U09Q8nkujxRrZTuV812yTdM4mfW35/ngQN1vQjmUyU8s1GB5CO7sji68rX4OYif2fnytsRN0i239HHOCNkfV6ULg26oimYMIMpaB49KX3Rtdgr6f3HgMjfbyjbREvtyIBAwPRp77kISZ+2KK01ptB9mEzXsKMZIYIlIYbUV1zJY2GtcJ43g0SM+2PQBpi9EDqQHWrxfLh9KrK2YHb5Q4SHjCDQHedvc5+X3HCY8kU8KZnkJIjoA6ScRvlbc5Yx+gPQ/xMtv5UqXLJTkqmNalY94lv7EQL97V1KLOCBBwU3jj6NZPGhnhBhR8lKkJrckr/5mJkw6ZIK7VpnCjzWzRwnd3rSeE0POlrvcPkjXruZ87VImf91hPZ9PK0y8ziB8aP0YZISy9QVsjkw5+0xrjZGw676R484c5rkPz35QhgjUZqyXFKTqq0By54/mE43cwyswvhyZdVAMsnJNx0NcjOkBPU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(122000001)(83380400001)(921005)(186003)(4326008)(86362001)(38070700005)(38100700002)(76116006)(64756008)(52536014)(8676002)(66946007)(66556008)(66476007)(66446008)(8936002)(55016003)(110136005)(54906003)(2906002)(5660300002)(41300700001)(7416002)(33656002)(7696005)(53546011)(9686003)(6506007)(71200400001)(26005)(478600001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JbRvfC1svW3fAAYEkNXlWY5BntK9mrNbEf+dpMi86G7YvHKftpQKwT6a5NMA?=
 =?us-ascii?Q?ub85ti1vQkFQSHI24EB/U10OzSD4vOGWdTTtplvlXnB2N0YqrFNwPu0w990F?=
 =?us-ascii?Q?EAnu88nH/3sNs2zZ08QpUZHUD9V8+l7Re6vguvhjFWW1dfs+XA0jiVLiNblG?=
 =?us-ascii?Q?m1dJdKtklL4Ip0HF3JW/H9H0MeU4Gw/HtTNky1y4B+Tz/d6zuAQ0VOzOeTAq?=
 =?us-ascii?Q?hQ+YuL1o3Mf6LAjp1vYzDPxxHLneKb4D7D2XBXNXnwHV3a5PSz2VB4VloREg?=
 =?us-ascii?Q?QaeM2wFrKHudP7dB3mF+AHY+VbJa7qusal4qJTlhqvNR5Y6mS3xUlJUuLlt9?=
 =?us-ascii?Q?kmJgmT3Gf559Bb4C1FeiLLRXTXf31mNi/hTEUoBzZInvZrlEyknInsJhm7n8?=
 =?us-ascii?Q?p3ggsRXxaX3vh1AiGW4gZBcA/Ii5JexgqJyl+JLv4LcbeeBhlb7kRJixlLIo?=
 =?us-ascii?Q?hP3rpohH34sY3tJD3RFDWs6nG2hw4rvZvFAoVZG40xKBBk0ep0lw55F9We6H?=
 =?us-ascii?Q?crJuB2tzgD1ECKNi4NBUEdOnbIgYILpeCIbIjnI0wFvsKxTqgI8cRSvv3OZL?=
 =?us-ascii?Q?MdruHKATWzHaDpJH26diwYvHIej3iWgrrr5aLUMtZ0zdfcxbxS+Xhg8ey4JX?=
 =?us-ascii?Q?9ES4CzXHHRoV0L9Yc//bkaBQtO4gzIMmUPlUOENeq5rpCZUifrqryQyEXJDH?=
 =?us-ascii?Q?JeWXgIzbXkCsdq8MUkcKLbCwU+NzvGVTfJxgmMbdiuvJVQEqKLp4KZpmDv8X?=
 =?us-ascii?Q?s6KRF59dqA2X9Q8/O9Crzx+KFIjr4T4Ys60p57+fK1ZbHhltDuakJMvYlg0L?=
 =?us-ascii?Q?pESgcgpmY3GW9B3gdq9IaPjQogHmmhD2uE3FBjAHw5+o1Vz1pTqAqlA6AEBm?=
 =?us-ascii?Q?cOqy+pHjeHVOepJ4kbM2z6Z26B29GV2ofiT5PUyHL7tJWyJeEqz9oTEzYH85?=
 =?us-ascii?Q?gqjdWqL2FLesvz3Qxv6GG1U5Qq8THgfCSun6vRtrrk1V+8TSITV9YknMU1Lu?=
 =?us-ascii?Q?gmR3Qg9THWHOBaodcbo6/DmrBZNtZeeiGZvGauMGaKWF7UaprLM3NXAWZ2kC?=
 =?us-ascii?Q?/z6q5hyXEbspBVL+2BPDO2ySc/301kUr6OXU1l9UutolsCgvMbq48QqSjZZk?=
 =?us-ascii?Q?Qeh3pDqZzobhZAIyBWQCYgcgYfvBiJZcoTARlofpSUS/3kF68FsEVrVHI4PP?=
 =?us-ascii?Q?hkP4VVHs9y03MrCTGqRZLhuVihWv7h4PkWh6bBv1iPcLa9n3szvnZUWRbynb?=
 =?us-ascii?Q?ombNQ8he6OcqD47Y7XHHt6r9j6eGY61oylZcvYjhTNWqL7/RxPzSs/X7M3md?=
 =?us-ascii?Q?JOUU3xmt1ZNFTBhC8Q/O1EXvZZwWwKzi1plpOmgN71IJ0RVNVoT51Fhs5Z4B?=
 =?us-ascii?Q?0e/6LsNL64Ytg6dX2Gz7XsC0igpyfQG4+kAEMKEVPRjcFXDALFj3yzgixPar?=
 =?us-ascii?Q?UyYxvS0kjbCD72suP7QC9N1EVRxotsZLhjinC0ODpCM+9MSp0gB8ILzbWwlK?=
 =?us-ascii?Q?UMfiW0SCp3i0ZIJHtHS5okndZmGagAI2kB6f2X5fXOZ0EK5yriXix5HId7de?=
 =?us-ascii?Q?Xu1B/gGaY9WinghRYJ0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eef739e-bbcf-4db5-f334-08da947f4a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 05:26:05.9394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jpV1rnSD2KAcfdGHXAjxMyRvHid1aL1RE+apDGCPA00NIaiEc3Rl8o/6TA5cIPnMhnPQpt97ftXNy+jNe8rmyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Sent: Sunday, September 11, 2022 1:12 AM
> To: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Michal Simek
> <michal.simek@xilinx.com>; Borislav Petkov <bp@alien8.de>; Mauro
> Carvalho Chehab <mchehab@kernel.org>; Tony Luck
> <tony.luck@intel.com>; James Morse <james.morse@arm.com>; Robert
> Richter <rric@kernel.org>; Shubhrajyoti Datta
> <shubhrajyoti.datta@xilinx.com>
> Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>; Serge Semin
> <fancer.lancer@gmail.com>; Alexey Malahov
> <Alexey.Malahov@baikalelectronics.ru>; Michail Ivanov
> <Michail.Ivanov@baikalelectronics.ru>; Pavel Parkhomenko
> <Pavel.Parkhomenko@baikalelectronics.ru>; Punnaiah Choudary Kalluri
> <punnaiah.choudary.kalluri@xilinx.com>; Manish Narani
> <manish.narani@xilinx.com>; Dinh Nguyen <dinguyen@kernel.org>; Rob
> Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-edac@vger.kernel.org; linux-
> kernel@vger.kernel.org; Borislav Petkov <bp@suse.de>
> Subject: [PATCH v2 05/19] EDAC/synopsys: Fix reading errors count before
> ECC status
>=20
> CAUTION: This message has originated from an External Source. Please use
> proper judgment and caution when opening attachments, clicking links, or
> responding to this email.
>=20
>=20
> Aside with fixing the errors count CSR usage the commit e2932d1f6f05
> ("EDAC/synopsys: Read the error count from the correct register") all of =
the
> sudden has also changed the order of the errors status check procedure. S=
o
> now the errors handler method first reads the number of CE and UE and onl=
y
> then makes sure that any of these errors have actually happened. It doesn=
't
> make much sense. Let's fix that by getting back the procedures order: fir=
st
> check the ECC status, then read the number of errors.
>=20
> Fixes: e2932d1f6f05 ("EDAC/synopsys: Read the error count from the correc=
t
> register")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>


Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

> ---
>  drivers/edac/synopsys_edac.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index da1d90a87778..558d3b3e6864 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -423,18 +423,18 @@ static int zynqmp_get_error_info(struct
> synps_edac_priv *priv)
>         base =3D priv->baseaddr;
>         p =3D &priv->stat;
>=20
> -       regval =3D readl(base + ECC_ERRCNT_OFST);
> -       p->ce_cnt =3D regval & ECC_ERRCNT_CECNT_MASK;
> -       p->ue_cnt =3D (regval & ECC_ERRCNT_UECNT_MASK) >>
> ECC_ERRCNT_UECNT_SHIFT;
> -       if (!p->ce_cnt)
> -               goto ue_err;
> -
>         regval =3D readl(base + ECC_STAT_OFST);
>         if (!regval)
>                 return 1;
>=20
>         p->ceinfo.bitpos =3D (regval & ECC_STAT_BITNUM_MASK);
>=20
> +       regval =3D readl(base + ECC_ERRCNT_OFST);
> +       p->ce_cnt =3D regval & ECC_ERRCNT_CECNT_MASK;
> +       p->ue_cnt =3D (regval & ECC_ERRCNT_UECNT_MASK) >>
> ECC_ERRCNT_UECNT_SHIFT;
> +       if (!p->ce_cnt)
> +               goto ue_err;
> +
>         regval =3D readl(base + ECC_CEADDR0_OFST);
>         p->ceinfo.row =3D (regval & ECC_CEADDR0_RW_MASK);
>         regval =3D readl(base + ECC_CEADDR1_OFST);
> --
> 2.37.2
