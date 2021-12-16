Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85277477700
	for <lists+linux-edac@lfdr.de>; Thu, 16 Dec 2021 17:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbhLPQIa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Dec 2021 11:08:30 -0500
Received: from mail-dm3nam07on2049.outbound.protection.outlook.com ([40.107.95.49]:64481
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238921AbhLPQI3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Dec 2021 11:08:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA6wufUMn27Q5H4rFENn1v6fpQamii6vu/QnMKQD9svLR7dvBunlTDoEaYAzD0Zvybc4h5J0YZ75UCh0BfPNCkOJaQ8hrJpuRmCYYWyGbjwsjlnXqG1CkNs/m7aV7GxqD2XxbVp3rVVrbN0si8+ocasv+mfkf/dHPAOUmt+sYAimkhltMO94a72Ld87BxLl9ReZtjftxeAndzzjxQbom53VlrqMIuegnGsTm/8/2lOAkRaeSqTC9yGRpldq0dgsfCAFuJ5WqScQ6SGvicGTkxB3/yO99RO6W6gNrjIIV7xGddY/kVgwFyjZ7lAZmYmcLYoxyspz6YPrgjoMV2ETwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLzlyTqFSsq2eP4ztXkzCpSxIausjRcxpLqixVptBNk=;
 b=cC0jmsSlbJ76aOvXPaCm1XjQH6qEDogcG1ti4QXXL93+6LXrUuWTG75ePHawb4JM4hga5Nan6lbjOGjdVJsI2k791/G5OwQmes9toJzZkPSsWzqgjxnE2QbKd0VgPYjVtYBLE9KI1mb8n8IYD3fmpA6J3XyMWriMIn/EzKsVnXfCwbUnHH+tk/PmV4hmaZH7ErxcHfIJmfyc1ihdbmXKrqizCjkRQaW+H+NOx8nJoZW+AjX680fGHbATckzyLWAB8BxButvo7x8U5mQn7PlcPgNDTiAhZxwaw0wpgLmAt73Gaay/swLfYI6uhBobNmw2zyJt4Dg/bNqKzKibe9kGpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLzlyTqFSsq2eP4ztXkzCpSxIausjRcxpLqixVptBNk=;
 b=gMzaV5N20U+lGNOnirzEeIZCqmcEW+q94Ka/qpsJSMwRaC1cK+lXwXpBOfNuU/gWPoKmJzG3eWFsHuOCUahmpkP92/gRdx85Qi+KTxSBPoaWnjYOYu2OGidJpsWpHuVrwN2U3AVf7/x3L9ugpncVwF3gRT2mJA/byeiTjRI7FWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB2480.namprd12.prod.outlook.com (2603:10b6:404:b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 16:08:27 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a192:7073:258c:28b3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a192:7073:258c:28b3%6]) with mapi id 15.20.4778.019; Thu, 16 Dec 2021
 16:08:27 +0000
Date:   Thu, 16 Dec 2021 16:08:18 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        william.roche@oracle.com
Subject: Re: [PATCH v2 1/2] EDAC/amd64: Check register values from all UMCs
Message-ID: <YbtkcppejpW8gHqY@yaz-ubuntu>
References: <20211215155309.2711917-1-yazen.ghannam@amd.com>
 <20211215155309.2711917-2-yazen.ghannam@amd.com>
 <YbotciKVDsH1Fl1H@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbotciKVDsH1Fl1H@zn.tnic>
X-ClientProxiedBy: BL1PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::31) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e9e3c30-51b3-4f16-292e-08d9c0ae4b5f
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2480:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2480A8F55127D3FB3CE052F5F8779@BN6PR1201MB2480.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCuf4euo/mtJiqlUzwJHKpCkIGzUwm+RRpg2ap0mswW2Erog+DyHao2AV9LLpawL0O5KPiaru1hi7TB3iTAo2iokhLmc9pki/zm1g1qplaFCr2/sWM3Bv5cUru9w0P11MbedX6rGzJMTv152fpyRq/HaLk3hX2MEs7aRCP7rP4iJ9zwRSzCRTgx/+oFx4erzWQjpsPVl9CD+P4AH2ZBbH5muLCKNVDtbUyaeAD1CbBAS9AvO4eTcv35Y9DPa61gDnRZOb6NL0O5exkaplRiQW+O2NBy/ktgApcH8iRoLQ9TWJTd0nJiZnlu9vsQL3qMeCajeSvWE1fNAKQm5zeWfJCHWlSf0zgxe/J8r7nvn9a3go8xbhPkl1URgxOCQanVPkVkdo7aysGcidaL8npuT6FZYgRKDgPCTZjIgChU5nl/DYPBlXNKhvrhbStWszoPXwDNcj46oY4WXIV8CAydhJhhJOKGaWovi6SDl30DAI0YnG0OpsYXOnVxzgj1J4xxndrwGF0QSMePW1idlqf14vdUrjAE/4RGrfu7lBGGNL6XBrzR01Z7Tq6p1IrmYnMqAJRb9aOz+D0pqUYJITZ2zRcMb16MD5rzcmkdaOh+yOW5o9xs9UnWIDnoiyV560anVy0mzwy9ljofHIuvfvkKRYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(4326008)(8676002)(8936002)(44832011)(6666004)(86362001)(9686003)(6512007)(33716001)(508600001)(6506007)(316002)(5660300002)(26005)(186003)(38100700002)(6916009)(66556008)(66946007)(66476007)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mBrt5vZz5/0UhNk5mAQCSCjqOPpedGH3tUEMaQOgzwVzcuabRps0FRBh5XY2?=
 =?us-ascii?Q?I3pTpPHmPTMlAJkXAlxtwKQ0zgUdVqEU+K1dep05ILVGLFZE2331tEF2OTAP?=
 =?us-ascii?Q?79XRd67e7cXevTRw1ycJ0SVx4RZEPq0n4SMHBqpscusk8zACUhkaubbr165n?=
 =?us-ascii?Q?muO+0wVAPkCHvZCKiUlTFBiCidK7Lr8iDD/oZX9bolD6i5EliphYi3DU7adg?=
 =?us-ascii?Q?2eVBSvOjz61uiCfUX4j4xOrgvF4w5qtVL9rwsWzVvhyH57mgXDatRowobFvA?=
 =?us-ascii?Q?R9LliWBsOUNNJTV7d4aI3A2iU+yrvIcHn7BHN+v7nKZZ7XX1qA/crf06NsZY?=
 =?us-ascii?Q?Th+nIUFCCQsdN2j5Sq9zrwvvPH5fFIy/1Zl1PYrOjzzsy/EM7ag1Bk5vzOVx?=
 =?us-ascii?Q?9nuzbqaUgUn5pdLWmfCZuhym9CjvktBg9sfej/y8jgvGczjRQ/MM7pggYrlV?=
 =?us-ascii?Q?X1NzpyfZBk+mS9iBraq1sGKODLraBOi9CMI8ERxBxrZ+1GyviNunqRxf3e5Y?=
 =?us-ascii?Q?MjP86xpTqvyPu+eRnURETCw4PkKsL352Lja/dXqD+0RjOyIiVGCvwco90pjj?=
 =?us-ascii?Q?9KFhhfm6KhTsLaBrwUKWGarUiAdGSuFO1HlDD5AZwqW4GEGdjLT6StFJlwr1?=
 =?us-ascii?Q?dnz4LzOq4UYOv/hiLZ+ItVIpVj9kkfIaSoMmgE8scAnNug2OYu0EqmYYKFuU?=
 =?us-ascii?Q?zzveEXCn0Nz98QgBoJji3y94Adb5iQ9ysnDCy45DajkeeceoiyAsFS+hYc2R?=
 =?us-ascii?Q?zofZ0RArpvxz9APPkqp1bxF16LX//LAHnHzRnXmKK57MU+HESA5keD8QrATf?=
 =?us-ascii?Q?fwboY67mIgU8H40yVuZPYLN+yYtpFnmSLxg7+zjdt5nDoXGOsmpkCC+BnU+q?=
 =?us-ascii?Q?4ovsA9B6EoD0OeIpFf2EzCXcldDIhTabNb4MJBeWz+3cHemHSgjt6zPhEWJc?=
 =?us-ascii?Q?mixHYiyVFLxVc/EZv9mvx4qz5aj0Lo6nchNPNvYwwZ0Z42KSNMkQitetaZHO?=
 =?us-ascii?Q?2Ev/n4CRBfZegULxm9fx1IuFe7zlTbwUReAd+prXkQftQ+SbAf8X/CK1xUEu?=
 =?us-ascii?Q?Ft+B3qJFQ3AylkDbbyIeP26DLTm3RNJMPKEHBrtYPmbl28WYoi4cDscLuuWd?=
 =?us-ascii?Q?uPw+TbOZjAbqxxQpz3KqbGRYNM574flxm4CQRI/Kl6IBKdJ7xOX2Ado4Wu+g?=
 =?us-ascii?Q?NZuujPQcJsJbeTBMmo3+pqYm8xxO+ukfVTKevpxAyD/qSLVFjXvH1+rexPit?=
 =?us-ascii?Q?G66lrmUTbZRvw93WK+NF01klodmDT2R4tAE7j6mRIxX4CQ0hw57V3KM86xXe?=
 =?us-ascii?Q?AZnexvdLrzSUZBdw0nwjYgr43vHxdBJ/X4f9GKgBHJ2H+vyrj/bfHicoY39i?=
 =?us-ascii?Q?e2fF/l2g1dXPA96qWLYlqbbIz0Gpu4XgPOe/LrrXLsCUdZ7SpNgjDBsU7g0h?=
 =?us-ascii?Q?rAAdiGD65hGkTcXsirwtVNXZLPjTrW2wrdWdYbq+6SBTlm0AygrtzEzQSRFZ?=
 =?us-ascii?Q?ia6e+Va/pd/m/C/cfVDwmNTPLTmuDW2l4Nho75PZmFecxS4gPuT7JO4lhDOc?=
 =?us-ascii?Q?D91t+9WXAsGJ1a1cQdBzS5AmeGY0D1kw8RztI1jFL3ZKhRAvUNVpuo0QO9wS?=
 =?us-ascii?Q?rkpd7R3tIxyC70g/FqC66Q4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9e3c30-51b3-4f16-292e-08d9c0ae4b5f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 16:08:27.3349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqsc2Cx2ZGPx7F2692/o3xj+WLlS7q6jweND92Z+uJnFraV2QUHLJniY6qc2TbXM2maFU8oYIhRMtTe35kZj+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2480
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Dec 15, 2021 at 07:01:22PM +0100, Borislav Petkov wrote:
> On Wed, Dec 15, 2021 at 03:53:08PM +0000, Yazen Ghannam wrote:
> > -		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
> > +		u32 umc_cfg = 0, dimm_cfg = 0, i = 0;
> > +
> > +		for_each_umc(i) {
> > +			umc_cfg  |= pvt->umc[i].umc_cfg;
> > +			dimm_cfg |= pvt->umc[i].dimm_cfg;
> > +		}
> > +
> > +		if (dimm_cfg & BIT(5))
> >  			pvt->dram_type = MEM_LRDDR4;
> > -		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
> > +		else if (dimm_cfg & BIT(4))
> 
> You're working here under the assumption that bit 4 and 5 will have the
> same value on all those UMCs.
> 
> You're probably going to say that that is how the BIOS is programming
> them so they should be all the same and any other configuration is
> invalid but lemme still ask about it explicitly.
> 
> And if so, this would probably need a comment above it which I can add
> when applying...
> 
> Hmm?
>

No, that's a good question. And actually the assumption is incorrect. It is
allowed to have different DIMM types in a system though all DIMMs on a single
UMC must match.

Do you recommend a follow up patch or should this one be reworked?

Thanks,
Yazen
