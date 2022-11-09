Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1D4622BCA
	for <lists+linux-edac@lfdr.de>; Wed,  9 Nov 2022 13:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKIMnx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Nov 2022 07:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKIMnv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Nov 2022 07:43:51 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D0613E3D;
        Wed,  9 Nov 2022 04:43:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gx3ocCQeuYQ5tofVzP7HnoUiXEqrsdi3bgfO7o/mPVtMby+KTgN2BH/O2QkYQMuy+eiQAOcExp5W/eX80PsCoLJI1k6QTbrcPNXwBB7X/PEV1e9hIEjk5GxzCKVytAKsGrVmU+3ijlUc48+BxhB/IJGY+hXdwEEtfynn/VTskeyne9+EAc7uAT2DEVz5+Vqe0bLIKBZ3Derlvc56krtlN+WNXK89q3XR/1nB+C6U8HxdYiSOP9oN6oPvyH2eJezzVNEOWgVYnFfyLbWW3DISH1Qr/hDqLPMYo9iFY3dt0XW1HDZ6qIkxSBGLkfpuNiLQFLK9Ayvq+cc18iJ/ynxs3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwoCLpVjxHy/pLOB6tNV5kXU0cpjgSH7dMTzFowmxA4=;
 b=Ex1y/nDamROs0sMwlEs771WdjUYqKbb7Ff74BQNKAOm7lq/tG12jnlC2QUZ8uZQuiRLULgQwf5IrMFoMI3mYSpjsB4mrDHuEup2Mrf+1wuivuuoREJvHJSPLQfzd6CUCX+OTbSj6EeZROZPn/rnXl6EeNtDTOk4MwGrZRHBEEXP4E+IkHaAbIYvJULao55yJwAsqHGwaexRLvSxnzibdA549h6y+GZ2akaw0NS73pGGbbhKhQLc2T1sepGUwUJSoI4b0b8lUYfEL/Vw8R4RM1RMFgEK5efFAfaVwY/rI7p8v/CplrbCxZ9bYF5fqqtr2e3uFN1zzTNuYbvxtFGYoBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwoCLpVjxHy/pLOB6tNV5kXU0cpjgSH7dMTzFowmxA4=;
 b=FCfExtCgjBSIDw0hZya2Kx+kS0lbz7/gHuzyeWlTinI1TohbriprFsyd6QNYRQKr63QJb2niNEaixYatAMtDX+s37xcVe1+fA3Q5T9KYFKo0fSL8h0GjyszF9vlnkOXWTC7hQ0q38W8z+PWpCqrtsHVNKB0y46LcCcBFjmzp2R0=
Received: from BL0PR12MB4898.namprd12.prod.outlook.com (2603:10b6:208:1c7::17)
 by MW5PR12MB5623.namprd12.prod.outlook.com (2603:10b6:303:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 12:43:44 +0000
Received: from BL0PR12MB4898.namprd12.prod.outlook.com
 ([fe80::3a2:a680:d084:77dd]) by BL0PR12MB4898.namprd12.prod.outlook.com
 ([fe80::3a2:a680:d084:77dd%9]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 12:43:44 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH v2 0/2] edac: xilinx: Added EDAC support for Xilinx DDR
 controller
Thread-Topic: [PATCH v2 0/2] edac: xilinx: Added EDAC support for Xilinx DDR
 controller
Thread-Index: AQHY8nGrKXLNRFdAhU+vVz82UCbqta41ZeyAgAEdYrA=
Date:   Wed, 9 Nov 2022 12:43:44 +0000
Message-ID: <BL0PR12MB489847621BF41F697A1D18F9813E9@BL0PR12MB4898.namprd12.prod.outlook.com>
References: <20221107062413.9642-1-shubhrajyoti.datta@amd.com>
 <Y2qpC6sk+1Wpde9h@zn.tnic>
In-Reply-To: <Y2qpC6sk+1Wpde9h@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-09T12:43:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ca831883-d1ca-4fc1-958b-9f5d41b1b6ec;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4898:EE_|MW5PR12MB5623:EE_
x-ms-office365-filtering-correlation-id: 6b5db035-6168-413b-bb28-08dac25009dc
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iNsoxwqCzqDe71yK7Ml7Pqd8XxC9q8W1CyeNrwqVmSQFO18xOkJm10hDRnqbc3r3nJMS1I+cpgJhBrL0aPvTwmslBMSsv+mskbPeJRMygfPvOZoi58AAZexoqwfxGZhhCWhpKexGuM3uplrVTCVzPJ7IpohSqCIs2l1U83BrihsdGeRMc/L2rLt8yZib8/nXSV/2N3YJhCvpKGRnFVB0hHvfwoe3rUJIisGeuq1d6iYde+YVD6M/AW8u/QVfDr3ibfNjT+rxSYYsPU5FkKl5z83yl8lJQpDgM4DNNiE/ELrgUQpPgCBN0imL9WYNUqDcr5aR3MMF9+3KH18v6zN9Uwm3cbaOPKoaWi8jBMRDDdXLreRp1iQHrataegIRpaWh4uWQSv3usHuAVB/aj3jefgpKNb9QulRWsCz7UoYzvYBoR5W5wZfiZRXDXB/9ityIJakW1NtSbE8psFwujaE9AWksaT3EqjSZKo4ovm+xOCD7gzsWkanyHZCmGcSxigBRq0xhi3IO4Q+dlf9zCGe5YOalSPhiCVayvc24W9SLhfW1xkOEsAP/jhQzr1gCgXNAwwhWdx0/hCjfYctI1wwnE+DTxssPlCCMeaxGOSKnaYMY2rA/GtesxCcf3CwUmlacOPamsF3Zr2+V0zoNSabas3411RI9PIdVqNshQvva/6FVw9BCiP+EoOIlZmGX+y4lgeTs0+HpePm/vCC1GWzkXgOeLF4DHeAHuFnzIr1q3fnXuPpz6x7EHB8313wyb+ha3qgK1VC+mN18M4dYrEw0XHJWLuayVHqmLgNHtjnRfoiMr4RCqGT8cIgA3z+Dxs5Ehyfh58HKe4cqJL6MLZzFDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4898.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199015)(86362001)(33656002)(38100700002)(186003)(122000001)(38070700005)(52536014)(55016003)(45080400002)(8936002)(41300700001)(8676002)(83380400001)(966005)(54906003)(316002)(478600001)(71200400001)(76116006)(66556008)(66946007)(2906002)(6506007)(5660300002)(26005)(7416002)(66476007)(9686003)(6916009)(66446008)(53546011)(64756008)(7696005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bvPran/+eAMDpwtyjhEM382felCD8Y/WkU9SHEVgKzhDeLB2xaRWW7DjzWUz?=
 =?us-ascii?Q?y1AmnUcmnvoV4Q60p9g3RK8CIO3QgmJNar7nHB6NeLfmr+e6qIwEl/GWgd3e?=
 =?us-ascii?Q?6oFfb+u7fxic6CCcbDVE673FGO40sPqPj1ckPDpdM6fxOmC7KjbvAwUZXN+J?=
 =?us-ascii?Q?T4fXwR5CZBrwZKu+WmG8KeaVMgSzTbwCcAELjL3L8r3eKvRfz6dTN4KkDZp6?=
 =?us-ascii?Q?iku+3JZi4JMTYr8hV9MMXn3W+Z4IXmNxwVg4XUEyp9VUm8YfZ0WSowapoRu3?=
 =?us-ascii?Q?OFWTfaXyH1eXTBcvlzPDzk/1uhhKFDu/MQmnaDBT2qpqWjIAnxUOb2T+RqzC?=
 =?us-ascii?Q?LPY/TnIhbTa4fVoDYi9bhgbRKiBCMkzbWVr5kpExJEN7LmFrRb9XDvBbMdXq?=
 =?us-ascii?Q?gjplj/tm1ZNsAozPmqCnSv1veCk7djbgRrxeQl6MA9LFEHCRU29xiPxh5+QL?=
 =?us-ascii?Q?Y0m9AJ8ShQ7R94yPCjqL6UQN1+m5mEH2Jvn/TeBpjFjN4ciTgjs5hVTjWfPf?=
 =?us-ascii?Q?cQ9qjvHYW8eNQ3Cl/Qvp4fR1TIhIswRBsNU0H0t4+lmksu0DWaqPUbMP/KQK?=
 =?us-ascii?Q?th/lsPf3CPNwHFnKICKXAmZ2Pyl2x7tVKGN9Kd/qiKJ+WBsWFAvHp/UJ6tqS?=
 =?us-ascii?Q?+HTUva8UOchgDxXA8oV3fobX48vBfvdi0GFRQsvs6dVW5RU1Qtl7mMHoNa+p?=
 =?us-ascii?Q?SQfEIDsDs+qFeu9ry2IWTnkSXJTrgXEkzpBU6UjJ3EmNfhbHqYL4pY7Ue6sG?=
 =?us-ascii?Q?YrEEGO0dx0/UZVotbeivn2Xl3xrjYEXfRbQcZKDfcyveelZlE1uIvdPcxA5t?=
 =?us-ascii?Q?IobvoKWECASvgMeGcr9jp//umuj2h0vnQNIkwF74Y3hNvwGYtuQQiMs1YIkX?=
 =?us-ascii?Q?6WJ4hfVG4yCLqzEijhHbBrAyxfOiNatNYtxyEOFeMjOAh8eYKtStEh+x5jSR?=
 =?us-ascii?Q?a7pVrc7b7Rf8PaUSLrdaKPHKuzHauuur2NBoB2G3g6F9diIjpgcnMy6gHADk?=
 =?us-ascii?Q?DAz/Hx/jOiQ6Lqimjkz2VCffbqrNm571Sg34nyjinB1Ne6mCNEsZokGOKymt?=
 =?us-ascii?Q?haPR0Ce0hI0vKQaHtyNw2XO+zME+QMZJDK+WhhaP7NHHKSK54C0+ljshcazT?=
 =?us-ascii?Q?7tHUiMNdna18IUnXPNqlna7BqEfRWbTvhVxc7j9MB9ha1UoIZkUYMRDEtQLo?=
 =?us-ascii?Q?NvB3R0Blb34PbgEA/ebV7+T0RVopcMlQ4/90eJsdsX8xKcQD8klUhWerYLI1?=
 =?us-ascii?Q?8xrfxkx+kRn2lvEkhhMaUYQ+WPyj6dm9inGgOWDL9cPbskj2R0WlPfwb46IM?=
 =?us-ascii?Q?BlgbGZV2LJrgxxFCZXllJxArtvDs6p0/9Io8CrlvjH6q6PUmnMo5FeYQfyAx?=
 =?us-ascii?Q?0rEqJlv84c5v2XqpB3G2gNxD5B8x43ISQ61F4ra/vURyQipJrhVdPLYWiDuc?=
 =?us-ascii?Q?YxR5gDidQlNNoKZ39Hf8t0wwFhVGXPccNxUcuuNQgWHbF+g9Ig6McjVj+e+r?=
 =?us-ascii?Q?nUkQnZkfxkzryPKXXlktjhr7gQ8GcctwzmOYKkHi0Kw69g5VbkV44LXqZFbk?=
 =?us-ascii?Q?bmLKU9j25PYG+8cV2xE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5db035-6168-413b-bb28-08dac25009dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 12:43:44.4666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9vtk2/ENzIaqZ2IsyxWpab9sLEG7vNk8rv9Qvy19djEpR8ufA+No+LpIxRoB7MrIdn7a/atsnO99USZZis5Z7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5623
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Wednesday, November 9, 2022 12:38 AM
> To: Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>
> Cc: linux-edac@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>;
> devicetree@vger.kernel.org; michal.simek@xilinx.com; rric@kernel.org;
> james.morse@arm.com; tony.luck@intel.com; mchehab@kernel.org;
> robh+dt@kernel.org; krzysztof.kozlowski@linaro.org
> Subject: Re: [PATCH v2 0/2] edac: xilinx: Added EDAC support for Xilinx D=
DR
> controller
>=20
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>=20
>=20
> On Mon, Nov 07, 2022 at 11:54:11AM +0530, Shubhrajyoti Datta wrote:
> >
> > The integrated DDR Memory Controllers (DDRMCs) support both DDR4 and
> > LPDDR4/4X memory interfaces. It has four programmable NoC interface
> > ports and is designed to handle multiple streams of traffic.
> >
> > Optional external interface reliability include ECC error
> > detection/correction and command address parity.
> >
> > Adding edac support for DDR Memory controller.
>=20
> Same question as in
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fr%2FY2qiRoiYepte%2FR4W%40zn.tnic&amp;data=3D05%7C01%7
> Cshubhrajyoti.datta%40amd.com%7C5caa7f12a7ca4ede4b5e08dac1bc8ea7%
> 7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638035312878146800
> %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL
> CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D3%2B4
> KXoDza2kloKAWI27LT5VvZqQ5DQQMJm91s%2F5%2FrtQ%3D&amp;reserved
> =3D0
>=20
> How many memory controllers are there in Xilinx boards and how many
> EDAC drivers can potentially be needed to run in parallel?


Platform	| Drivers / Controllers	|
------------------------------------------------------------=20
 ZynqMP	| Synopsys and OCM	|
Versal		| DDRMC and OCM	|


>=20
> Also, this is an integrated memory controller, ZynqMP OCM is a on-chip
> controller. Can we have a single xilinx_edac driver which contains suppor=
t for
> both memory controller types or are they completely different?

This patch series is for Xilinx Versal platform targeting DDR Memory contro=
ller.

As they are two different memory controllers (DDRMC and OCM) on different p=
latforms (Versal and ZynqMP),=20
so we cannot have a single driver.

>=20
> Thx.
>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeo
> ple.kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D05%7C01%7Cshubhrajyoti.datta%40amd.com%7C5caa
> 7f12a7ca4ede4b5e08dac1bc8ea7%7C3dd8961fe4884e608e11a82d994e183d%
> 7C0%7C0%7C638035312878146800%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300
> 0%7C%7C%7C&amp;sdata=3DJjvQZVXXAfJPS5tOj87QYzUdFhqzuZ3pO9Q%2BkQ
> 2IhTU%3D&amp;reserved=3D0
