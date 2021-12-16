Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F3F477643
	for <lists+linux-edac@lfdr.de>; Thu, 16 Dec 2021 16:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbhLPPrJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Dec 2021 10:47:09 -0500
Received: from mail-mw2nam12on2041.outbound.protection.outlook.com ([40.107.244.41]:23994
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231948AbhLPPrJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Dec 2021 10:47:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avG/M7czPNerzi8gqWO7xY4aDArKOQ3dBMWK5ti2XFkrorISlZxE/DLwGe5JR5U9i64AWBvCqH+lVUAQ5OHj0RTVfSa+ybVUbB/6HcYhZxeh5N9tejPUN2JWGslQIR9J2ngqbIhnLKTYvxKM8YJW6HfJj8bMRtsQtaEDVO44/kYawJO0ThWt5VU/WAF7N23bkziq37w7KbMJVo2GNCn5FnxFrOZbdaxkw8mYC2ccwXi/f7M79S7CBclhvowwpzlnQpojKT+mw7h+sdLGUlifhLaeXw37IYEj22ozbMSsxsqbeoBcxZqEfu69oZxdJbp+SmQUimB9sxYLQvEA2WZDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4g0EO5Oqzih5Kk9Y9koepMTpT+EvDulHNzOvre8wy48=;
 b=EfDG7KXeklk7qq4pgElbbcBX+3EZI4o1Ug3AfvkOzO2+kd618Nb+cUaq9z34mPcat5em3yATOPU5U0oWLLsTHT4aNOlYTOgThziZvT0TPE2jquNT4C3DWsLElriMSF/XmnXfnalvu7m9AoN1Qclx/ZqCEkGqLAlR2LXc5T18VYMCMnD90Si7mD6/XuS8KSTnJOTdGD9LwRSWpOwGgX2+ndMZow95DROP9hq8I4uVEJl0uZhlSSuJMRNgXwu4PzKM4b5LGrdTdP4koXAChIhJoCWX1JcxtuRZGsmxzSHkROfTMG+x5eVw4P9T1iE7sVfBpEZOAUuCgukFPZgZzw+0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g0EO5Oqzih5Kk9Y9koepMTpT+EvDulHNzOvre8wy48=;
 b=wv5bpBWlMNKTGY9sHvF+L+ZAuw5loWo+EtbgxslZWOKRxNElk2O+CxM5LJHreXqgAJO3UnSY7IcLIGlp9qlvUebQZOAwQnzx2bfC6hoq6zjhq9QSvVh6pa8bormx9N/Ul40x/Y83fXIIAo1hQ324vylryJF6B58O+NwpMx/i/ko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3364.namprd12.prod.outlook.com (2603:10b6:408:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 15:47:05 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a192:7073:258c:28b3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a192:7073:258c:28b3%6]) with mapi id 15.20.4778.019; Thu, 16 Dec 2021
 15:47:04 +0000
Date:   Thu, 16 Dec 2021 15:46:57 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     William Roche <william.roche@oracle.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 2/2] EDAC/amd64: Add new register offset support and
 related changes
Message-ID: <YbtfcUmWAFDWMG9w@yaz-ubuntu>
References: <20211215155309.2711917-1-yazen.ghannam@amd.com>
 <20211215155309.2711917-3-yazen.ghannam@amd.com>
 <d327bbfe-a3c0-9b26-569d-43e17dba126d@oracle.com>
 <Ybou1VTJ8oced4Ge@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybou1VTJ8oced4Ge@zn.tnic>
X-ClientProxiedBy: MN2PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:208:239::24) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e347ddd-c11f-4c3e-1371-08d9c0ab4ef7
X-MS-TrafficTypeDiagnostic: BN8PR12MB3364:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB33648841449C016DDB87A125F8779@BN8PR12MB3364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLWNtdRuaBIP8xfzmfueXM7mXsLecAtSM0n9lL/zMt+KjWWLj/Sf+WKFZsxQJcPlPwlZw6Ki6/I44iGVnsOBXAQF0SBrp3mziQanYl3uWHvseCLDgPiK4CIht097mgB7QSdECZco+LwBrcStjQhpEF8PALGo2g0qIlI9wjewIT14lYEyLzq/paJ0Y6SxgerT+ev4dL+JU+UGqImpGj+JKEHyz5YwAAX1wVSZT5m3OjDUe0jmuFlBp5vXzQsS64e4BdWfTzkj/AkheE0QE6Aa7MLxmZLDZK9pB2EbewTTMvyc2K61L48ahAgfCwL7iicReAociqZ5xd/CCaTNWaqWxBJ4UPV8MMlXFvYTRdcN04YZpXn04T+KUoTtbst1M53BGVH7Q6BoGUAQx/ggWFH1wMI11jO0/Giuw7k9mFxcrUlimu/QhMyyZhZlJ/IktIPwaEIPwmh3/MWXGM7cX9AY5sySghKs51WZ/b19iXJRFpxeBbKpqIreUv3yn8ztFRkVhG6EnmWsBdIgBJU/s3vx2flphTpatTKrpMhKvCXXMViB8kP0fAfcPO4zkJccZDOCeuUdcTsXiYn2GVtGBEPnS6HJ7pR1olmdlWbrNh4lbDjllNIsWNRfXNVoOxBUsJxF+nehtkCQNo9d4kY1MKlKtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(83380400001)(44832011)(186003)(4326008)(508600001)(6666004)(8936002)(66946007)(66476007)(26005)(8676002)(66556008)(6512007)(38100700002)(6916009)(5660300002)(33716001)(2906002)(316002)(86362001)(9686003)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ihLW8Zo2H99CUHGF8bXdJb7TlDxwFWB/r36WXRF72iL1yfHUQVr8VX7nnw9?=
 =?us-ascii?Q?HhbvJjZcyb2GKSerpIXlk6XbaJ3i27bT+NYyAP9kltFltybZLWiFhcpaR7IW?=
 =?us-ascii?Q?fJLV+db9AnmPKPVvm8K2az9SVwrdVJ/VGr3YnZQUCU/bVj5sjwroq3wdG5vt?=
 =?us-ascii?Q?nkzaBqwZgoqY4+LeHUKZy7Q3z/DKgtaQMaSyZnlyOrQ3rMzBeNz0P4PDzkEF?=
 =?us-ascii?Q?p8tHM2hU6ot9nCz051xfqRnpY0Q+vk1HpXLQXmZc4tzYU6Zv4kGyml1U5Grr?=
 =?us-ascii?Q?P/l/VntLoYoxF9RDyzFdMwnlXosC5JVAnJW9BMH/mV766hUA2+2TeG1kMAQH?=
 =?us-ascii?Q?LgRRTpNu1HccW5+6Guzt24pzISW8Igz/NInWnNT+As3b3Doyj/ERKAK2Myh3?=
 =?us-ascii?Q?Dce6xH529BXBOuB12EO6VA+109UiQBqHUnbokZ3JCr1HFXf0SrYlHtm5RFj3?=
 =?us-ascii?Q?Ex54Nb8mmQLn0fgPJ8PlJJLZE75UyLWL6jLo9rkJhH7wk5Wqy2LtmaDS1JyZ?=
 =?us-ascii?Q?s1OXnZdqPaBhZw/Ggt6m9VZMm2xJMsU57T8XCnyytFGpz85cks9pzXKJo3nF?=
 =?us-ascii?Q?ptcQ4fdI1MNLenqCa+/no+RY22M2gh29JkdNgnCzlDmBh6ez+D7ENNcUwsDJ?=
 =?us-ascii?Q?5QMpGMOPaML17wE5hAXI/k8aHHJRYYfNo+RGmvofBwygy9gbS7ZJDLFJduuG?=
 =?us-ascii?Q?G0Qb4japOjwU7EvH9+hx5+znqJPJY0Y1zGBhcW4wBsbsN6o11wvbhBalHpSu?=
 =?us-ascii?Q?17dbn3TYbSP+dJArSwz03J9gZCppzxXQAvlLoU9K84ei8GeNeYk3q/gTc3w+?=
 =?us-ascii?Q?+ORZ9EDw33dMppgMz/bD7WcuN0C2ZGiJXngEubf0HCw/6HG4D//sGx9KCceo?=
 =?us-ascii?Q?QJ3Ng5E/+TiyZC40MjDbRRJSEdKRkcepTy/O1LLgaDTNpez3w5R3ww1tWDJT?=
 =?us-ascii?Q?Jb8KFfNYy5aQtijh838kseRQSmPggChTqPYtsPofvXAOyJKMHVl3KIROWgU6?=
 =?us-ascii?Q?CTnBSMvXqiYPgYBiR1mCVoRm/yHP3+HvFQ0E/8oyut1/+lRewnhAtmrn2Q3K?=
 =?us-ascii?Q?EYILmVBzcSFlQExBCDigFOg24v2f+59RNIRCXEEZTUzB7K7Q5AMcPY/+tOdR?=
 =?us-ascii?Q?FA4xv+VmHU2MMqfDGu5xoWjcasx4yd3OZyXcMH4HpDR8g7K1e1tHyRoGKDn8?=
 =?us-ascii?Q?ikClNZJZyf83P6Hecp+yFknd6j1rB9nhukGlgnE+bNe28BX0WFWDOC+fmvNd?=
 =?us-ascii?Q?Rr5hq6RqBQJ0gu5CIgzFxlYxa9cesurtyCN3wpeAzR2dcK+YSJP4dlLnkQjs?=
 =?us-ascii?Q?Z3LyzI2pEIU9+L5TD2o7k45to63MyHKR1PYnt3F1LRlN36DyjNflNM52QsmQ?=
 =?us-ascii?Q?SP2fsY5zLwmjE/CbnqPrDC3b8Oe2U/JkmFAGMN21e5kaFBppJqL0dAlbF9R+?=
 =?us-ascii?Q?souo63x2Hf1fpnBbhbCU1SAU/6cib5DFv77mkJJKCl9+sJUadxKZze9mIJWE?=
 =?us-ascii?Q?fyfoF0HhLio5nIisJv70u7kGVp1QI9hcH9w4CO2dbaj67t5I/NZzcd0mZklW?=
 =?us-ascii?Q?YlmbDvRrTNbJ39hbgZ/kKwFeL+dCkNCHGJ5Dv5g1hZ13+mEty6OrW6EgIKEt?=
 =?us-ascii?Q?gH5d0q9t9qKhdnhtJVzUMW4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e347ddd-c11f-4c3e-1371-08d9c0ab4ef7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 15:47:04.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFfPfzYzSBkZoApY/mh3PQbAgrWoWkGPiYDg4VE0J1c825mNb0Cb8MHGiRZwxRIwrIF2nwSw3skp392nPosEVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3364
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Dec 15, 2021 at 07:07:17PM +0100, Borislav Petkov wrote:
> On Wed, Dec 15, 2021 at 05:32:27PM +0100, William Roche wrote:
> > > @@ -2174,8 +2215,13 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
> > >   	 * There is one mask per DIMM, and two Chip Selects per DIMM.
> > >   	 *	CS0 and CS1 -> DIMM0
> > >   	 *	CS2 and CS3 -> DIMM1
> > > +	 *
> > > +	 *	Systems with newer register layout have one mask per Chip Select.
> > 
> > Just a question about this comment: Can it be translated into this ?
> > 
> > +	 * Except on systems with newer register layout where we have one Chip Select per DIMM.
> 
> Sure, but without the "we":
> 
> 	...
> 	* On systems with the newer register layout there is one Chip Select per DIMM.
> 	*/
>

Hi William,
Thanks for the suggestion, but it's not quite correct.

There are still two Chip Selects per DIMM module, i.e. the system can support
dual-rank (2R) DIMMs. Current AMD systems can support upto 2 DIMMs per Unified
Memory Controller (UMC). There are two "Address Mask" registers in each UMC,
and each register covers an entire DIMM (and by extension the two Chip Selects
available for each DIMM).

Future systems will still support upto 2 DIMMs per UMC. However, the register
space is updated so that there are now four "Address Mask" registers per UMC.
And each of these registers is now explicitly related to one of the four Chip
Selects available per UMC.

Does this help? I can update the code comments with these details.

Thanks,
Yazen
