Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3588C6FF913
	for <lists+linux-edac@lfdr.de>; Thu, 11 May 2023 19:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbjEKR7s (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 May 2023 13:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239148AbjEKR7b (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 May 2023 13:59:31 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD759EC9
        for <linux-edac@vger.kernel.org>; Thu, 11 May 2023 10:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNwx80URPDksiYIEZQE22YrwQMaSBReNSGiS4L/15H+pRBORtORunpSeQguOMgWgjFED2bi/J1OQHfyfxs2oIVo+MIgyOieNRKgHceWrnoJy4FFEawLihyolv8Rqr38PbgVLYSIIbtrIU7zNus8MwRHXd+adsy7kpNUGyIHvAE9FFfzliEOrwqhsLsasKfD2yAAs5r+k/QOAta5cizSvyLyZ91Fsxq7Z0vfGcWpHyEuSCPDdC75OepcVd5iw+B7oZLkOAMOYuitOOMB+wEygrWc6bMN2/MUjvMeMNo6bnmMfejUlO8sz9/K6iq06tjhpP38L/cDV3KIFMXaSNCqr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HF/JIBl15NrvH1z4eikxQ/fa7KsysholUb+FwkkhwF4=;
 b=dyhq/l+X/JmG4fCkwp46reyUyz35o62DkUt70RaJkyysdhaZOd6VBUEFBk3s76S/9Fn5eKyU0HpnGDgt8/QvLt1Km7yUSf5ueruB942+egSh73FlSem9DWuD6YTBoNqvfFgXx2oa4o4s4VOXI04fm12yBUhjGT012UfLGCNRYZ5kMMSC0eU6POrW92J9SsSzYYxJjmyTutZhEclotjHzQ5Uq6joq6ZneKeEpe+rLA/9NLzBVsXuYIW13DyZrKLV9rqmTCzWoewtDNmPol3f64qeAMVZ+1CPb5zP7oCLGc6csUTt+SeNWCC1QMbPYPbehmxW8zd5hsLtEvjukPY1mFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HF/JIBl15NrvH1z4eikxQ/fa7KsysholUb+FwkkhwF4=;
 b=g2SAKrD4RcPrjMxmEj1Vj58V60bKqfVQCXboPW6j4xenbQ/J6xS5hEZDeg4fFdn9QUOTUhHZYeN1LSdN2931ew1SMTXyXVHXsFrEvKoBw4DOq4oFfIJEsN6k5i4SQ1TKin44pjhTeRTLVNYAzzBlJqIEA08yBtF+pX9hOe2FRJs=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 17:58:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6363.032; Thu, 11 May 2023
 17:58:42 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Hristo Venev <hristo@venev.name>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
CC:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH v2] EDAC/amd64: Add support for ECC on family 19h model
 60h-7Fh
Thread-Topic: [PATCH v2] EDAC/amd64: Add support for ECC on family 19h model
 60h-7Fh
Thread-Index: AQHZhDCEA9DVjfoe9EmqakdIfX+EmK9VW+7g
Date:   Thu, 11 May 2023 17:58:42 +0000
Message-ID: <MN0PR12MB61010720C2A97E177E19A49FE2749@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <d619252e-35c7-814b-acdb-74714619d62a@amd.com>
 <20230511174506.875153-2-hristo@venev.name>
In-Reply-To: <20230511174506.875153-2-hristo@venev.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=edfc6769-587a-4d84-8030-57c6715b75d6;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-11T17:58:13Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|PH7PR12MB7258:EE_
x-ms-office365-filtering-correlation-id: 21ae23b5-3b8d-4cef-13d0-08db52495b85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CY/pBGOaj2DGtSryDauvSLck9CzGMr7lxlmVJrsXe0jJYlzuLNJtdxPoPIM4p4VT6jMXxz+F3fCN7lbkknTBBZRzLMlx2+JTXCEnj285zAbWQRv0Q5RXpUAiZfcq9HxDQYI6fYiO03HA0+GUdWqF7xHfXhe5wYJzFGJDmYA/dpi5tt/Wk/AGLi38qDHiinqH2jEEFn0tq2aPCsoBJJzynl82aIik/4J4pTXCXo1ZwderN91sEECPMm8oSoA572OEoEi/FxQriwngsvaEGRHOnwuHDTZabVyIcQj9UI3s6knMIrhZvRvRnGdBRL7unb5SUqwCiWqGPxuSi9JWDXI98gSy92nxCPpvnzTTGlLtiGAjw0Nmuvb7wQRYOo4D4AGkmtnTUQp07ZisYpSeLpI/bnkXUv3r9VYgabPCplU8Pu6ijPcJB1ranKDSquAps0/s+9kYNZOkFofD6s6qhQCt8iB4Utp6tA4L7HD8vrxlZ7XHqn4lmoPCZoBUbna0Hj99+5dUD8/qkDe6wGhYZR6l5Coi8dtSymbBgcUo7w4Ebt195IkKfUhUmYs7lj/dNQAoKJPKy0djOnHTZ9nB8xQKtJkLAO2zzfQ0oxLjk2KInNo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(33656002)(186003)(6506007)(38070700005)(38100700002)(9686003)(86362001)(2906002)(55016003)(83380400001)(26005)(122000001)(316002)(52536014)(71200400001)(110136005)(7696005)(41300700001)(8936002)(54906003)(8676002)(966005)(478600001)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(4326008)(6636002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?an1RnPaLVwATwGqIzahX0C9Sc4bDkWf4dN26DxCEfcMHXlP1Al/Lee9UoWOZ?=
 =?us-ascii?Q?Mr/NJJ84zYeHmoE+B3gWlUQis/0T3XAWXuhatdx5K0kF28lOrOgp7No8Svsz?=
 =?us-ascii?Q?3WDbxon/mfU8nTZ0O/orNmXf9Xx+LybZFMROrkIPHslDVESoEk0dx16oHGpL?=
 =?us-ascii?Q?SCI34DOqC84jJcvFjE08iQvpXeZGGfdnqtKM2pQPhK+rSgYue2pAZu80snJH?=
 =?us-ascii?Q?o/XuJqUnqmilxgYXL6wnp3z5q4JeyN5wMp1CKCb4NVCYk18wqB2V3S1O+RkI?=
 =?us-ascii?Q?4YIo2hB3Sj6KoAXkv59fotvw/NbuwBQbWLGzpdQ5MvTpLm3Dz/4Ee9y5OVX8?=
 =?us-ascii?Q?fZ42KcG7Kq8JzcOfpEPKHw+PjSH3TjDbCukdQQC5px7J6I8vmAYzNTsp+/KW?=
 =?us-ascii?Q?uzR44oCH4MBx7nFy2bAY1/rcGD/vfhmRucBseTrAMULLpEbnexk/qsxrc9H8?=
 =?us-ascii?Q?qCgeK6XYgERhpbCSr8J3+vJ24gLEKHrOVxNu3FZKveRD11tCBh3w3E5aVfzJ?=
 =?us-ascii?Q?drZZFv6Azr69XwXf/j8V70u3g9FGEHRm/ps0SLR831RW0JW/EBOn1RiYfynn?=
 =?us-ascii?Q?9WeetEImtn55zLxsqUHIG/DbgmAUWXTrR9rmEpCyApbVuIAlDehD0x26kluz?=
 =?us-ascii?Q?s2XBp31z9FZsikV1a76NUZK4PhgfbjkeybokPgt6PuBaDseWhHyNrHW/Ehbz?=
 =?us-ascii?Q?gdmwLaJDpG+Fl4gjgNQOWQByAru75oQL2t1jBqPTLK0Ww3D0MFibyXZRPh2r?=
 =?us-ascii?Q?aTS8noJZQJlFlhN92kMyFBVIrdXqV5guCIWWjzZY5u/VuyGc8z6rPm0AQ1zo?=
 =?us-ascii?Q?+eHqquwSZNQ6ypkWANX7hsJlx4FWJER4QtKNosrQIt5gJkV0KXTeZKyXtLrQ?=
 =?us-ascii?Q?u5fXeWqCqePMvMVCX5a/yIfAQGf0xbkiYhdd711D9UTh2VUn82VI/1jHJFrK?=
 =?us-ascii?Q?7KWWuzHOxFSMjn6blMQJRSXsrsEDUy2zGkIVtx583/yA88mDWpoBPMmEu8co?=
 =?us-ascii?Q?0U2yp5x+QqI1DNO/dT43EpxcxPwB1ev4bl/bwExTKNTxdaEkhKRnAAL06B08?=
 =?us-ascii?Q?Co2kDwQ52sTngEss/7BfHKaGn4pO5AqnfyVFSqng4K2ZWaWQtxelcNvsw7Mj?=
 =?us-ascii?Q?x3s5wNi3/l8ts1pZO2JsrmtEectsYVgJQH2ml6CEUEaI7aL/zIQHr8mEo8tq?=
 =?us-ascii?Q?kuLyg3mjIxzXmc7y8mnyeoDB/ppgVP/bJ1ZZiCpcX7eTolDAKKZzxrLvK1eX?=
 =?us-ascii?Q?m5cQ9TnD+eq5f2dQTMRpQYymb+NFutiR7aKgzbtfoiE8vyxrc9ky0pBeUrgm?=
 =?us-ascii?Q?avCF7DJItAtmrEdWo35Guk0hAASLOsBmkCikq7i9tz+HBC6eTZ/k398Gv0pa?=
 =?us-ascii?Q?RzId2IF9xC4zCgthXI4r4qgvUnmun1Tm0PAK03Qli+WLltJuIgChW+UKmJyZ?=
 =?us-ascii?Q?dx3qU+aGIL4b45ccEmXBpwXoejYb6JD7/p+wDcT5uYCAM/LQ6SQfBujF7S1y?=
 =?us-ascii?Q?qX1Mcx5hH054rfgYyB+cAl/+gNeIQFCT/36HqlpLk1yD3eUqsW7DWaL1bdn6?=
 =?us-ascii?Q?WihIJwQkHcBPtzoHYi0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ae23b5-3b8d-4cef-13d0-08db52495b85
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 17:58:42.4429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NLv519ZUXjLMwXBm5PvaYEFdRAFwHDZKAyOZXwgIyAAvmakhH1xCWwM4x+FKc+HGLYgGAGMX4jfiAmbS0vx3WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[AMD Official Use Only - General]

> Ryzen 9 7950X uses model 61h. Treat it as Epyc 9004, but with 2 channels
> instead of 12.
>
> I tested this with two 32GB dual-rank DIMMs. The sizes appear to be
> reported correctly:
>
>     [    2.122750] EDAC MC0: Giving out device to module amd64_edac
> controller F19h_M60h: DEV 0000:00:18.3 (INTERRUPT)
>     [    2.122751] EDAC amd64: F19h_M60h detected (node 0).
>     [    2.122754] EDAC MC: UMC0 chip selects:
>     [    2.122754] EDAC amd64: MC: 0:     0MB 1:     0MB
>     [    2.122755] EDAC amd64: MC: 2: 16384MB 3: 16384MB
>     [    2.122757] EDAC MC: UMC1 chip selects:
>     [    2.122757] EDAC amd64: MC: 0:     0MB 1:     0MB
>     [    2.122758] EDAC amd64: MC: 2: 16384MB 3: 16384MB
>     [    2.122759] AMD64 EDAC driver v3.5.0
>
> ECC errors can also be detected:
>
>     [  313.747594] mce: [Hardware Error]: Machine check events logged
>     [  313.747597] [Hardware Error]: Corrected error, no action required.
>     [  313.747613] [Hardware Error]: CPU:0 (19:61:2)
> MC21_STATUS[Over|CE|MiscV|AddrV|-|-|SyndV|CECC|-|-|-]:
> 0xdc2040000400011b
>     [  313.747632] [Hardware Error]: Error Addr: 0x00000007ff7e93c0
>     [  313.747639] [Hardware Error]: IPID: 0x0000009600050f00, Syndrome:
> 0x000100010a801203
>     [  313.747652] [Hardware Error]: Unified Memory Controller Ext. Error
> Code: 0, DRAM ECC error.
>     [  313.747669] EDAC MC0: 1 CE Cannot decode normalized address on
> mc#0csrow#3channel#0 (csrow:3 channel:0 page:0x0 offset:0x0 grain:64
> syndrome:0x1)
>     [  313.747672] [Hardware Error]: cache level: L3/GEN, tx: GEN, mem-tx=
: RD
>
> According to Mario Limonciello, the same code should also work for
> models 70h-7Fh [1].
>
> Link: https://lore.kernel.org/linux-edac/d619252e-35c7-814b-acdb-
> 74714619d62a@amd.com/T/#m9fc20d5dc36074048ec5f1c0a5b01b7f972a1cc7
> [1]
> Signed-off-by: Hristo Venev <hristo@venev.name>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>  drivers/edac/amd64_edac.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index b55129425c81..c00f7e4ef366 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3816,6 +3816,14 @@ static int per_family_init(struct amd64_pvt *pvt)
>               case 0x50 ... 0x5f:
>                       pvt->ctl_name                   =3D "F19h_M50h";
>                       break;
> +             case 0x60 ... 0x6f:
> +                     pvt->ctl_name                   =3D "F19h_M60h";
> +                     pvt->flags.zn_regs_v2           =3D 1;
> +                     break;
> +             case 0x70 ... 0x7f:
> +                     pvt->ctl_name                   =3D "F19h_M70h";
> +                     pvt->flags.zn_regs_v2           =3D 1;
> +                     break;
>               case 0xa0 ... 0xaf:
>                       pvt->ctl_name                   =3D "F19h_MA0h";
>                       pvt->max_mcs                    =3D 12;
> --
> 2.40.1

