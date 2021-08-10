Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC113E5A45
	for <lists+linux-edac@lfdr.de>; Tue, 10 Aug 2021 14:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbhHJMpr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Aug 2021 08:45:47 -0400
Received: from mail-dm3nam07on2083.outbound.protection.outlook.com ([40.107.95.83]:55840
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240752AbhHJMpp (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Aug 2021 08:45:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6y5vfMbFQLaF2HDxvmSyJp3sc8fs034Gb7EbIcktIqKxujokHTD2Hq7lcLylEgm3PT5KKAgA2lTYQVCyZGj2h/HGNav4uXBaL6Ws2FdvexMpxkVIub979g3HN+IeXOaSB84k5AuEvDJ+iArYMeT0Frh9v1Funz2CKyO9Z0WyHvGMQDdEg/i7L7q/fPjhgphHlZV2S6E3/aMa8HnYQSEUKJMXM9R3VOs4U0G9ZSBV7fGU+1B0SWxIkcbSfJS9ltcUwB3A4ojOwRobHXB1pgrzM7zFl8E9w3xoTyo9LBMcHEhUTMpEJ+L3p8qjRAnv9jWEQGRt+ey/WjsD6rMAvNwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY4kOpHj79YbgJaDrCBlm6wAWu95U7J8fy5nUSKOlT0=;
 b=jpywbgqOyJGttc7mPZxG1x4CzJ07yBb3Ngkx3iHa4Fqdkv4LvT8Zfq/h/HP4FGzn4ulU9yw/il9fPQrsj+aFVXxmHX2O000h3GSbSohGIc7CfRSsAsFA0VfILEGn29b0eIslHw0BOmgz0OX1tCAoaVtCERCPZIP5/R1JVelB9Upwn1di8NS15NZ0EwldO6NuE8YRYv/3H0Sk6XGWD0PM+LCOAMZfytkmIVNpy2jYT1VHlUbephp3iFl80eMa9VRaF9JCM8oZU72iODwwb7VJYsPhWhzcREvOk9NWp9bcWFu/aljn9QgQyPd0JFh9LPXEc1whi+B2LOrY1RXs0X6XBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY4kOpHj79YbgJaDrCBlm6wAWu95U7J8fy5nUSKOlT0=;
 b=YB16PKN4RAMrzgsMsYNsDRgW79RdJuBge4nh0hD3PIeMD7BJRJQym+XhLzG7JDuVoCs1Z8wLuyNNAcGivvQoDRCKJbuH/xHrEdDSmPWf99Rv4eVeF6MVilLp96sCNj2aTRVQdtbcyyaQe/lY7RmXVIE0/HQQ/zmL2IB/e2RdZ44=
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Tue, 10 Aug
 2021 12:45:22 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::38e0:44fb:fbfb:c8d2]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::38e0:44fb:fbfb:c8d2%9]) with mapi id 15.20.4415.014; Tue, 10 Aug 2021
 12:45:22 +0000
From:   "Chatradhi, Naveen Krishna" <NaveenKrishna.Chatradhi@amd.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
Subject: RE: [PATCH 4/7] EDAC/mce_amd: extract node id from InstanceHi in IPID
Thread-Topic: [PATCH 4/7] EDAC/mce_amd: extract node id from InstanceHi in
 IPID
Thread-Index: AQHXbb9UT9Tpw1TDtUar5E92vFMCPataUzmAgBKbmXA=
Date:   Tue, 10 Aug 2021 12:45:22 +0000
Message-ID: <BL1PR12MB52866A0EDF20FC659EA6979CE8F79@BL1PR12MB5286.namprd12.prod.outlook.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210630152828.162659-5-nchatrad@amd.com>
 <20210729163245.GA4318@aus-x-yghannam.amd.com>
In-Reply-To: <20210729163245.GA4318@aus-x-yghannam.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-10T12:43:29Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a8994e13-9daa-407e-a815-520861499c8d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e0a6b94-a6b0-4edd-7643-08d95bfcb7f5
x-ms-traffictypediagnostic: BL1PR12MB5061:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5061F003F60532DCFF58BDDAE8F79@BL1PR12MB5061.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kmGsC/eVO0wRZa73iokmvuBwUuBz57FFhyYCiR97Z7HTQScWUa1TnpV7gri9XZMC5iRJ67LEodnJZC2jzO8YtClvYXWE2EvLRPD4Cm/1B/yD/4w2msGQpnuBpZetbQ/FllI4gL2hvXr8zqjw16o8SYCrXo9InlKTeLagrDamvIl8W5kPpkgUg8tt7alH2hwhkoqGY6RB8yvtvO+0Wdy5T8/4qw3Bs843Muaal/cKs8Ie1qOPaVGycjmBHD9UMFTIT8Xc4kTd2YGCHh2PB8WmCdYLNy9/sL/hjOr0eoApHwtPLKwwiCtSXcfQ8xqOfFTb8Z+DmhcFB9ds5+OxXIiSMWwJMH7TXdJ+qB0EWVxwgCIV5jCm4lod/FJ7w/IAb4JLxguwxEUJRVNcyfrL8EYJx98pUy/sFs4lSKyGEE1EofkXzcfvcYB0nnxJ9UrUG14UNvj6bNFf9SEQ8N0fUqv7Zeq5HnNayMwJTI40Mw0mv9PpIffDnT5ktzHmRUitA/MPBAkjdKq7gcIm8NHp6uAj3Ov+J9r151m9V3I9EG9hS/XbnVBNrnkYEbVNRc7xPbLMGLfL9sjj9bA99DcWqO6+EJBP9sMGz6Gh9KcloaDeiA825t0sA+AsORMlZ8jQEGlrVvSVPKFJEEOH5vyD1gjTwSiaYgCGU/pJ2DuUWbpTb05aWWjZ1cVb+0UJ/hP2PAw7fb6V8g8/4jf7pQzW7PHaX4hVIBueAkzgj3ye/A7Sr5o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(8936002)(76116006)(316002)(478600001)(186003)(8676002)(54906003)(71200400001)(66446008)(9686003)(55016002)(66556008)(66946007)(66476007)(64756008)(5660300002)(7696005)(122000001)(6506007)(38100700002)(86362001)(2906002)(53546011)(6862004)(38070700005)(33656002)(4326008)(6636002)(26005)(52536014)(83380400001)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F1kAhO+b3KSkYBrh56rPpd8n5NrU6CezpFDcvKEJAryGo+d/qDlPQLUPHWSn?=
 =?us-ascii?Q?tfHQX6IA8Hj2u8166tTk65FQyUPcbVyLa1fqY7KNPUDGF3J8vpY2QuJFK1Ko?=
 =?us-ascii?Q?oVZpzD73Nd56KNjHuwt5QyMhf1+M1MOOF5X5TB05TxMU4t4Pq1VfQXKMtGOW?=
 =?us-ascii?Q?pqljSa87YeGY82WrNSyTC1eVjU15IZ314RJUkGFfE00a3nRXnLADFuzBBs4l?=
 =?us-ascii?Q?6C1ns4NwImWgqEHqsqEYknNTrqTTgyijBxloP2Ap9F3b5NBP54vGvtVUwjV2?=
 =?us-ascii?Q?FDAcqkOZLLy4GbUrUWxP5BmP1ewRgssUQgo3py7i29z2cDerQyGuGug6q0Gm?=
 =?us-ascii?Q?s5lolXy6PoELEAgfQLS77ZkNmWsazjqSlzMom37KQD1yLlNfLAh41+EyF3B+?=
 =?us-ascii?Q?MZPFH9QJW/Mt4nWeV9jjXEHghIay+5UMSIhaY+tm2LYvEdBY2VscQGHCt+Wz?=
 =?us-ascii?Q?/Xx5PBTdOFCLuXg4E8qOXhVs8IyiMzAZzQqBESYVmBG5SQ1JaM2xiWA1sI0T?=
 =?us-ascii?Q?LnNMvm2XsMbv2czjek0qmG/y8ksTKySrbakWE8U5XgAhLs31bfwg5SFcMC90?=
 =?us-ascii?Q?JoKQN6YmV1dl4TYGQgkoPPDkfCLX65tDuVnZeQQsakioX3Af5QoaDrj4dSvc?=
 =?us-ascii?Q?MpPiN4GK960F9qkzp63KeEgFbt/doS0xItISOmHMRzlAENQGa8Cbb10WaSEb?=
 =?us-ascii?Q?gJoPMlmsi7u98igeXYnGL3SsD19KOf+Q8yqWHxkia6K7nSX/9KQzWzMGFvnU?=
 =?us-ascii?Q?gWo5TYwcCKiIKe8cdwl6PXEQGaZnPwk+KMKfAvuLQKBUlsM5YPbMDafBBdZq?=
 =?us-ascii?Q?msFdYa5f8bqqbr6wxLgnp9w1iZ1CltxCYfNC6PKsmVdNX8oFKz0vZzrOGb2k?=
 =?us-ascii?Q?qCi7/lcnA4IdZdGroiiTQpKy6KtmVVsnk4l04+7GU3H8kMWtbM/jylDhqQtS?=
 =?us-ascii?Q?y4pcR+VP3gYObC5q7VNOq2Dhxz4gRr+7xC1/Yl2bNfU7f3UNcxn9a9iZ5I/2?=
 =?us-ascii?Q?VSN0pI6qNuzYY0VONxMBB8jVOamk1r5rqPhWyhcM+hzgBoYrrFahamONlrqj?=
 =?us-ascii?Q?+B0Vk/tMr7UsoC3HmPfqF/5edlR2P3PuA8tThS0CP2/6sxVHaJV8CT/1dRWN?=
 =?us-ascii?Q?Nz627oA+5jT6Aly2/ptSrTdzO/214BJzxZyRdhcEuvO9t3UUkO+ubNrCeqf6?=
 =?us-ascii?Q?2lWyYVtFyx9HmAk2xFlTWx3g19XdlfDdgTmD8X3bc2NyNlUln1vbgVEp7Gv1?=
 =?us-ascii?Q?lUV33nVinMXTDSfT0fgwc6+W3HJE6tOCG3UvTv4FasTZuyPr61+2MDzNgjE9?=
 =?us-ascii?Q?Z57pCyyqaEhkeD9yW68mS4rK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0a6b94-a6b0-4edd-7643-08d95bfcb7f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 12:45:22.4136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZr8x2bX1/WORyVBxMAjMI5T0HzPwQVMtUWjls/GkAzrGmo0GI1AbDLbJKGKhRKvr2A9AYiN9WahvwCN7b3p/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5061
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[Public]

Hi Yazen

-----Original Message-----
From: Ghannam, Yazen <Yazen.Ghannam@amd.com>=20
Sent: Thursday, July 29, 2021 10:03 PM
To: Chatradhi, Naveen Krishna <NaveenKrishna.Chatradhi@amd.com>
Cc: linux-edac@vger.kernel.org; x86@kernel.org; linux-kernel@vger.kernel.or=
g; bp@alien8.de; mingo@redhat.com; mchehab@kernel.org
Subject: Re: [PATCH 4/7] EDAC/mce_amd: extract node id from InstanceHi in I=
PID

On Wed, Jun 30, 2021 at 08:58:25PM +0530, Naveen Krishna Chatradhi wrote:
> On AMD systems with SMCA banks on NONCPU nodes, the node id=20
> information is available in the InstanceHI[47:44] of the IPID register.

The doesn't read well to me. I saw this as saying "bits 47:44 of the Instan=
ceHi register". Also, the name of the field is "InstanceIdHi" in the docume=
ntation.

I think it'd be more clear to say "available in MCA_IPID[47:44] (InstanceId=
Hi)" or something similar.=20
[naveenk:] Modified the commit message

>=20
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
>  drivers/edac/mce_amd.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c index=20
> 27d56920b469..364dfb6e359d 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -1049,6 +1049,7 @@ static void decode_smca_error(struct mce *m)
>  	enum smca_bank_types bank_type;
>  	const char *ip_name;
>  	u8 xec =3D XEC(m->status, xec_mask);
> +	u32 node_id =3D 0;

Why u32? Why not u16 to match topology_die_id() or int to match decode_dram=
_ecc()?
[naveenk:] Done, used int.

> =20
>  	if (m->bank >=3D ARRAY_SIZE(smca_banks))
>  		return;
> @@ -1072,8 +1073,18 @@ static void decode_smca_error(struct mce *m)
>  	if (xec < smca_mce_descs[bank_type].num_descs)
>  		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
> =20
> -	if (bank_type =3D=3D SMCA_UMC && xec =3D=3D 0 && decode_dram_ecc)
> -		decode_dram_ecc(topology_die_id(m->extcpu), m);
> +	/*
> +	 * SMCA_UMC_V2 is used on the noncpu nodes, extract the node id
> +	 * from the InstanceHI[47:44] of the IPID register.
> +	 */
> +	if (bank_type =3D=3D SMCA_UMC_V2 && xec =3D=3D 0)
> +		node_id =3D ((m->ipid >> 44) & 0xF);
> +
> +	if (bank_type =3D=3D SMCA_UMC && xec =3D=3D 0)
> +		node_id =3D topology_die_id(m->extcpu);
> +
> +	if (decode_dram_ecc)
> +		decode_dram_ecc(node_id, m);

If decode_dram_ecc() is set, then this will call it on every MCA error that=
 comes in. Rather we only want to call it on DRAM ECC errors.

You could do something like this:

	if (decode_dram_ecc && xec =3D=3D 0) {
		u32 node_id =3D 0;

		if (bank_type =3D=3D SMCA_UMC)
			node_id =3D XXX;
		else if (bank_type =3D=3D SMCA_UMC_V2)
			node_id =3D YYY;
		else
			return;

		decode_dram_ecc(node_id, m);
	}

This is just an example. Maybe you can save an indentation level by negatin=
g those conditions and returning early, etc.
[naveenk:] modified the ladder.

Thanks,
Yazen
[naveenk:] Thank you.
