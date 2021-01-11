Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70182F208C
	for <lists+linux-edac@lfdr.de>; Mon, 11 Jan 2021 21:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390899AbhAKURw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Jan 2021 15:17:52 -0500
Received: from mail-dm6nam10on2053.outbound.protection.outlook.com ([40.107.93.53]:3449
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388548AbhAKURv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 11 Jan 2021 15:17:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Swehp+jfl87BxwDnGuWTiEOjdGZnuvXlCxvhy6YFOnq/FDt1+fJESOY8ExHU9JWYKEPznx+NimEbEnSXW2sNtvU2CzKeX10piUCM2tOmBII69ZSYFJVO9pc2A0NW73Gbf2nL5oXf7MhiuX5S9C4wSiz6KPIZQYdPKdQ/H7D+Rxr2yaewrFXjb+YTRBDiVlZ8D1Or4hz2/ZJcvV9eu3bXEwkBbSJKefkcK20o38IOQkmsgUZmS820BcGpVXcN2ehd6KoZMQV2XIXBsyeo+34gidsSdz7NWFKCeKskJmFD74u30YKxob7ubJOnpPUvbsB0Bf2D8mxfRyKnzBO7Y7nBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+SPlDaJ+jFoqEG0xb8YhPEyM2Y89RvTXzXXTsLG9Fw=;
 b=IoOFw9EiA4Y3/Nd0yATytjjPIBdhA8tC4KlBLJN2FnOe2k4OR1Dg+q6RXZ6b29jnpPcl5ORG6DU1G6aU1Bm7Rh/8SxO8+Zu3G8gHQ6EFiBQU8udG0ejRwiyi1SWqhgHvhZL2Xmj8qsofaNvS4CKshpVImi7eb0xNyaDS+2M1teP7pSiWjd9zahpnrzhKrYSLM9hleC54WJooR5ji1MoZj9uF7mL1Bfl6y7aAB2BcfoH/OdhgNt1hdeTyyeBy+Ws2DVFQH8qh7VrkFjnsraISfexGOaZ8k9+GPWCnkcYY1SSFzsUrOHU43lSMS2g6jQnXQ8Bo0WR6LO7tLwgpWqUA0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+SPlDaJ+jFoqEG0xb8YhPEyM2Y89RvTXzXXTsLG9Fw=;
 b=bcurvl1rqRK4CsNFZWNdpYnMFyNRPrRgeZVFmk4X+Zn5uCDyEhDCooAsbVXksTYTWL4GwDycqWJ0DGNc1DxoV1SU9CrcxT7KAB5LpzGSwxm/0IJrqqXLuF4TOE+aFXt+oJToU7wqxz6ki0hY35iQ6mpmI18Tx/c3WRDRHBGbRdU=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB2481.namprd12.prod.outlook.com (2603:10b6:404:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 20:16:59 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d%5]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 20:16:59 +0000
Date:   Mon, 11 Jan 2021 14:16:55 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     WGH <wgh@torlan.ru>, linux-edac@vger.kernel.org
Subject: Re: Unable to set (or read back) sdram_scrub_rate on amd64_edac
 F17h_M70h (Ryzen 3rd gen)
Message-ID: <20210111201655.GA929024@yaz-nikka.amd.com>
References: <a9cdf7c2-868a-8f67-ac4e-c6bff60552e2@torlan.ru>
 <20210110113308.GB22211@zn.tnic>
 <a7e91287-cb0c-7d40-fa9c-c87d9692f229@torlan.ru>
 <20210110120019.GC22211@zn.tnic>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210110120019.GC22211@zn.tnic>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SA0PR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:806:d0::23) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.2) by SA0PR11CA0048.namprd11.prod.outlook.com (2603:10b6:806:d0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 20:16:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6858609a-2989-4a52-c400-08d8b66dd9b0
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2481:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB248104BE28E3168EABCF4408F8AB0@BN6PR1201MB2481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:480;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XEcq4OXCx0u/ZuvzAq8c8IZRCaHbcoyzq+ameiWWooXSJB4ohfo0eZS9xVTIVbx8YjSMy8SxhReyAdVg/fl9O97tX0TA7dh2IiWyYpKx4USC5Xlzk5eHb2m6RLr2j1CsZxpQlU0tdgKxuV4gWQfJLRwUBHswwnL6GNByUgjnd9nLHnxCNUD4NKIFPsu85+AeL6DGdGQ1fK+9qIizD6mNG0rltg3Gt9NT3641Q53DeLfmJ5KZF5yuTjwEwCmhLMFvGTPmZN4OxNxgiZzh2GNQOMQEEsPlz7cx9IZp1geeEo5rMTlXuUlxeGDPfzU8a+ReCGUOMFaPSsIkGkOnu2lb+TPmI4CPhX6cGsaSmYPwyLfbPhme+xu01PeHd9FCbK2w1FmQBfAqxvf4vKDglXU8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(66556008)(66946007)(4744005)(86362001)(8676002)(478600001)(66476007)(186003)(55016002)(2906002)(316002)(26005)(956004)(7696005)(44832011)(6666004)(52116002)(1076003)(33656002)(5660300002)(6916009)(8936002)(4326008)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?3QAx2X5NURZWaXZhmlx3Cfo3E/+m+XqyfIAn9cwHQTNzVSO8vJ5tPumMl0?=
 =?iso-8859-1?Q?AQuIK/uc4fhG6HrgOJkysYBYTf6xoLtOLI0+GrcjQgQatDtxGV860gW0El?=
 =?iso-8859-1?Q?iVWk74mmuGnGFbUXW90DD1Q6WELtN1VQ7FYT4pEjisXCO5rFG/nDZxmgaG?=
 =?iso-8859-1?Q?wA+jwtwT4k9w3pTg/I7VAFd+8p8Kc7vKYbe/0iAPHbn3XlCBF+m8REf+jn?=
 =?iso-8859-1?Q?/hXa0qe1ADOhO/oKSK8EUzxlrpynbhLGgPrPvyN7jTm4L6H7HjY4bCioT6?=
 =?iso-8859-1?Q?k4BIVb3upVh1HUhVeEJjwekJLIDegqbg5g5VgYIR9iVr5Irzp4Wdis64uV?=
 =?iso-8859-1?Q?nXFxJ10NyF2T7Lt19+GCuUxGyrPylKDM52hV7yrpKgvHRB1447F38+TY+0?=
 =?iso-8859-1?Q?Eze45bwo5dC1os7zC+jAEelL2YBrSYVM0pjpa+bdh++lKzuWMyVHSNz9wm?=
 =?iso-8859-1?Q?zy/8rtHkdqEI5vex68dgyoYjrA3MUrXi7/mYCNKpYUapQ9ATWGp6YMQ1ud?=
 =?iso-8859-1?Q?jforNRLqZcXj2f0LSlKEmKRRdE0ILlKpDlYf2Bg3ZS/CtQ2G9FslLKdVvC?=
 =?iso-8859-1?Q?qRHHFslX47HBcFqm0fpqGQEJFEYtPHS6LX9GDL0rGrpfw6GAnmQrMEL+SM?=
 =?iso-8859-1?Q?pdu7eSnqhnj88hbId8/8+tuEMtWl4ExVLhyeGPtpuKd+yZuFhSKZW0agzE?=
 =?iso-8859-1?Q?VC/Novcqn59SvLWWXwtDawLc0RskETsF6Q7AVjZl1oe5b8hamvG8/yN1th?=
 =?iso-8859-1?Q?RtUua/LEVUZJcno5xUBy5zrhFxL1Uu8sXJHRTrhvj2GPYe/fEGWwXvPD2P?=
 =?iso-8859-1?Q?Yt7kG7VRxZulQQ9N4Kyd7f3epC06o68i+0U0SnvtHHUJYRsricFjwyBNDE?=
 =?iso-8859-1?Q?ucMkWvVUHvB36ShvaBA97omLCrZWsjTPjBVGkm9Vh1LISdeJFpa7BKTAG2?=
 =?iso-8859-1?Q?0yoUV/3QRXRH2MWasBPQZ+Xz1fOOjs6tn7nrLpzQ3sf6WiBN3JVf88Mzg6?=
 =?iso-8859-1?Q?AlgIgb8/nQFSdzFL7xwHgdw7NBeSDkxriRBRDE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 20:16:59.1526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 6858609a-2989-4a52-c400-08d8b66dd9b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uoCbOmZn5AbOSVLLbF98pSuJ3XDfxO7079ibAgN3MK9gKwqHh4EccK+nPL/rCv+QhkIxZiusv+Cci+1hwIe32A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2481
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Jan 10, 2021 at 01:00:19PM +0100, Borislav Petkov wrote:
> On Sun, Jan 10, 2021 at 02:46:52PM +0300, WGH wrote:
> > > # setpci -s 00:18.6 0x0x48.l
> > % sudo setpci  -s 00:18.6 0x48.l
> > b214bac4
> > % sudo setpci  -s 00:18.6 0x48.l
> > b23225c4
> > % sudo setpci  -s 00:18.6 0x48.l
> > b2648984
> > % sudo setpci  -s 00:18.6 0x48.l
> > b27b9dc4
> > % sudo setpci  -s 00:18.6 0x48.l
> > b293f504
> > 
> > Whatever that means.
> 
> Yah, bit 0 is not set so you're getting scrubrate 0 returned.
>

It looks like these registers have moved in newer systems. I'll track
down the changes and write up a patch.

Thanks,
Yazen
