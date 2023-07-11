Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B370A74E9F2
	for <lists+linux-edac@lfdr.de>; Tue, 11 Jul 2023 11:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjGKJM7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Jul 2023 05:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjGKJM6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 11 Jul 2023 05:12:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A15FB7
        for <linux-edac@vger.kernel.org>; Tue, 11 Jul 2023 02:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VB+0LPbZLCtxjt/JbSBVroAK8EPTUE+g1CaeFPUTCe+rpcuVvpZ1fzS560OOhRUaPN+PnAIG/ppjcIVOqmjGTtcXO1leGqwiai4VFMdU1xGeU0pyfVYbZ5s3g+BO3qBdFYwxQv6tJ3lrNnzEAPwBvP+mVGaYyszlqABv+xFGIN00CZWwYwt+aghZGKaBfhjQHKzj02bgJR+E2Z8gPsWyx8KqgjOvMUwxroSuLESuCiApmL4YA7rVN6sDKCU+zjCPhs1A0MNV5a+N+nlPhPOPXyGi9/VW55z+yKkJisMz1aKQgpCS1C6CySOWZm4HbuVG3dLxzPgwxi8w2bDv50ua9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eg2csF4Eu0RAf4h+iIyfg4cS+Gk0wr1ixWlVWe4wf/0=;
 b=jDD397TF3mxS69SR8Hr1QLUBk8jwkktoFbIU0HI6sEIjWIygVjkQLKMgZfLS6N3skBcMv1VdvbzPju55KWe8qiYtOxAEn6Ns7fGLK+BDG0a5OFdfXW2TsJVQMWWeKcs2WBd0z5qOT59eilP6ozzPV35IBNkQA7kQ8UUTAnBaLKDQWLxG1aagMqbFcBiTcyBli8pAKyWRNmkDv13OHH6Z4wkovfCkmXOnIIqMjf0ogfIa99jQ1im8BG6dxiDlyvY/PxJdTSkBAdo6tFvfzcRv1ZWT9aAWTOKtWooU4nVgxMzoYEQrUZltoy230p3n++79W4lamL+uCjgPx+kqJfa1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eg2csF4Eu0RAf4h+iIyfg4cS+Gk0wr1ixWlVWe4wf/0=;
 b=y2zIFJfOY3hswvY4LtztrqV7LMhC1Yzk90OI7tAGK79l3+KF1zQVM/FYqFHXTNFNkuiF5W8yXenXiixDDfBBTPF4XcSmV1AV3jibBkmFjw4kuoOTJH8I4KpiHr3A3bOos1ofKzg++mgoqXVSUJ1D653Jz0gk9QebjzA245WDG8c=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 09:12:53 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::8aab:ad25:8953:1c7d]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::8aab:ad25:8953:1c7d%7]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 09:12:53 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     Yiyuan Guo <yguoaz@gmail.com>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "rric@kernel.org" <rric@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] EDAC/zynqmp: Fix an off-by-one buffer overrun in
 inject_ue_write
Thread-Topic: [PATCH v2] EDAC/zynqmp: Fix an off-by-one buffer overrun in
 inject_ue_write
Thread-Index: AQHZqqHEFtNCLltNEkye9Fw0T7A7SK+0V1VA
Date:   Tue, 11 Jul 2023 09:12:53 +0000
Message-ID: <BY5PR12MB42587D055AA65B84C23215F3DB31A@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20230629113933.4112456-1-yguoaz@gmail.com>
 <20230629155122.539186-1-yguoaz@gmail.com>
In-Reply-To: <20230629155122.539186-1-yguoaz@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4258:EE_|PH7PR12MB7818:EE_
x-ms-office365-filtering-correlation-id: 354c49a2-366b-44e6-2733-08db81ef01e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NmeGcLQrAuwfUjVW5ChT2DSEvtAj/Pcn7IXrL1EwftrowHd+7Lm/s5WjoIUhMRDIJTaoQh3DIngEcBe0LXWJ7/prCpkOIBnGCOOiAo9RCgNEwWVqpOwqAf+iNec9zmpLVVQ4GXB1b4VshIjYyY2tUiuUmTAYIBviEU8ottyiqTGKq/CqKiR5nQkVpt+bc1MJ0xz8WDrBbfcPWhYqIQt202+pHxuNrwg2hC/NXa/adJwPonOxMh2/nBB7ok3vs7Rk57lGemI+n2CmWk3GLhkfQEAT7Y4hr/t7Ze9u5osowOUxvK4a4C4fDN8GzoRwDRt+bhWwLA33ZCsLqoEnHTlvRBva+qbh4hklFM1JC96yJAWthjbQLrvAKefhD5mDIB6nXuWOnroUpX+iSOkRpqFRtcXGCPGngbE0NH/Iz068HNU9Ix1XHWglJ7nEIoCq7Af/r2WDaMg1MByoMdIu0l8OFZHKi+qdg98ZuIe5XIhPW9uX4FIl++5Vuu96hCVdD+wzHwAxnDNwCCV8+GeNDhJdhmyC6Z7mNf++0lca93pNdSibbjKQwgQKBPGnSt5fwhydYe8itbGoZE8qKFLUYKZiNY0Tkdr6vrm45bwWn9M+NciZDk6ynW5JwBxjmJu6Hxv8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(26005)(186003)(53546011)(9686003)(6506007)(83380400001)(64756008)(66446008)(41300700001)(4326008)(478600001)(6636002)(66556008)(316002)(2906002)(5660300002)(8676002)(66476007)(66946007)(8936002)(7696005)(54906003)(76116006)(110136005)(55016003)(71200400001)(33656002)(122000001)(52536014)(38100700002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Qr+MyO9Lt+nyZXAU+9NDA09wV99QRDTu2uoRt9rWEMRN7/D3wNazE3MNt7O?=
 =?us-ascii?Q?gSqrNYv2d2YPsYDTJ+AxZdc27q2Q1i1C8+J8S+uRk+hu9R+jq/XJqyr8yduQ?=
 =?us-ascii?Q?DZfW5QFBt2h7/wo8w8o1ICBPaf8Uipj6WvKZYR+eTPZtE08n4IVRu1BV9t2W?=
 =?us-ascii?Q?9gnBUgrfA8MzG7B03rFyCjf2YWmbXHnSSAgh5Fh7VLQZDjhI+MuQu9Hm8kA1?=
 =?us-ascii?Q?48p+RoRvnj8s6YHhNFfE8FkrV903cvPUSBDzbJ6e2F/qtTWbiPt9Ko7XxLKy?=
 =?us-ascii?Q?xdGCqq9OL5w964bShgxx7l7mJpoDuUNQKezgFET01EE/BrJKE6TyfqBZr4UT?=
 =?us-ascii?Q?s2q98iUFR1cfi2EgvDOXKomJyPU+n46LC4dv7sM8up0L3TN/9cyLwUZ2wFO4?=
 =?us-ascii?Q?j8Tk6Yr+s+uvAhMeNKA048KRZnuCTzy/LdEgHHRYAqG3Q8A0EifBMk0d6vWA?=
 =?us-ascii?Q?v0TtFedjVZaOjiNtNmIBRUMQHcZbJ305XyT/He1pAdBYZayR19GRbs4Cafh5?=
 =?us-ascii?Q?Q9Q1zBqTZ2jPesV43XOwNVSmwlav0+9iK2CTUhJs3NIvOUmH+JxtxIcWrtcO?=
 =?us-ascii?Q?6gyt4qtu2GOXMBbqiha/wTIvrTA1tMfkLWie8tu0UMS54A9UtFO4DsSqAwzT?=
 =?us-ascii?Q?InZ3SPQcumf1luUD4TCmkJluLXtF5BEhOM4zHHYtJxPk1UJ1mJ2uB6lpqdAR?=
 =?us-ascii?Q?q84KR0reVQhQd1P367Uw0qAAIUKEx6sdqk8N2Jgli/gQi9OUdFlOj0y6HUzM?=
 =?us-ascii?Q?nqrsVnLyI4Kjpere25w8KerA6qFtbHU53HPYpMFQSZvVQQ1vbbwEnLCSmB4k?=
 =?us-ascii?Q?06FiiYgIMok/MsQyghda53z+JJf4VPLRq/5x9vvUeAPGEwDCZ14XvaBtSZU1?=
 =?us-ascii?Q?yDk0xAeieNPwcE8QiyVnuQYPdMEJDF1ZPLF+PBH7NQRjRQeMsvgOWTry+zbT?=
 =?us-ascii?Q?pL7x+BVKWQ566ROmn/TXAb7/RpZcq5Q795VT8M/b6WML0x1MFqps4G8wN3uu?=
 =?us-ascii?Q?/bSqwMl397mQFEUHIzCn0BokSRg8JBfDeE0TvJO4MPtZDweM4Y3+4HXCv7k7?=
 =?us-ascii?Q?sKskqMuayPPYctZ+6E1/cqE9NlA6bJhcxD3/0FZpEUr23VmRn3iu5Oyd60C7?=
 =?us-ascii?Q?NPjWVrPsllQXEBNVSJ9ErPDf9LtK+u9KgO1aDjv37BKRuG0Rjis7hStdUTRp?=
 =?us-ascii?Q?Ad/h2dbmKNnzON5dH7ARyzivmrBMVGWFGw703H5TCd54T60RGnIvAG75CPZa?=
 =?us-ascii?Q?Ks8ugDojugAulf2Jlz+jSWfDRs8/8sBOH7JhN/FlwQrdIbgGFuDUzGH78Kzx?=
 =?us-ascii?Q?aabPrayYrX/XIWWDYEYspDpWgPZM4eslCqHLObQXximgEl4ddY3QGTrL9S3O?=
 =?us-ascii?Q?zdqVmTo+KB6X7bIm5QZBcJMPc3BRZfcQUOsE1N0rFolQ0Ij2uZ21+HqWqDLJ?=
 =?us-ascii?Q?iWSE41yn6IMvbejiznztQC9ki9I6/zF3MdxvwHYxyWsqxodHbfZ9w5ZjdiXR?=
 =?us-ascii?Q?jYiWzSV55Io8wkz3E9XlBFe9FIFct1XgniBVvVABsPq20k/cz2YVPLmKJcne?=
 =?us-ascii?Q?uD3O4QYaMGaVmeA1mSY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354c49a2-366b-44e6-2733-08db81ef01e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 09:12:53.1413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: teLxzAyHy1BHJCRP2NGD59TLN16ygZwu74pTkdAEbONKopqE3fwsU3GEjV2BHbOGR2bNn1G5Z2X6JwN8Mvaasg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



> -----Original Message-----
> From: Yiyuan Guo <yguoaz@gmail.com>
> Sent: Thursday, June 29, 2023 9:21 PM
> To: Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>; Potthuri, Sai Krish=
na
> <sai.krishna.potthuri@amd.com>
> Cc: bp@alien8.de; tony.luck@intel.com; james.morse@arm.com;
> mchehab@kernel.org; rric@kernel.org; Simek, Michal
> <michal.simek@amd.com>; linux-edac@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; yguoaz@gmail.com
> Subject: [PATCH v2] EDAC/zynqmp: Fix an off-by-one buffer overrun in
> inject_ue_write
>=20
> inject_ue_write() may access a local buffer `buf` at index `len =3D sizeo=
f(buf)`. Fix
> the length value to avoid buffer overrun.
>=20
> Signed-off-by: Yiyuan Guo <yguoaz@gmail.com>

Reviewed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>

> ---
>  drivers/edac/zynqmp_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/edac/zynqmp_edac.c b/drivers/edac/zynqmp_edac.c inde=
x
> ac7d1e0b324c..bd9c1ff4b5e9 100644
> --- a/drivers/edac/zynqmp_edac.c
> +++ b/drivers/edac/zynqmp_edac.c
> @@ -304,7 +304,7 @@ static ssize_t inject_ue_write(struct file *file, con=
st char
> __user *data,
>  	if (!data)
>  		return -EFAULT;
>=20
> -	len =3D min_t(size_t, count, sizeof(buf));
> +	len =3D min_t(size_t, count, sizeof(buf) - 1);
>  	if (copy_from_user(buf, data, len))
>  		return -EFAULT;
>=20
> --
> 2.25.1

