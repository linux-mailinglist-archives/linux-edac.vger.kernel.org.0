Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655482791D0
	for <lists+linux-edac@lfdr.de>; Fri, 25 Sep 2020 22:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgIYUPD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Sep 2020 16:15:03 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:65376
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726818AbgIYUND (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 25 Sep 2020 16:13:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1f3ireTSF0F5r2wBppe6+ZUrq1LJpjjjp2B0z73XYr1r/XHfi75K7I4JQwEqXMdZSVYf93xgCjLmBBECcG5iO0W6pR0aTd6SSwRMz13+33ewSAvNtHNZ+KnUZ27YyO4LtAWiWcb4aVxufQ1D4z8Ju6BaYoz8QiiL+JNswYkng74CK/hFUHfu5VvKMeDAbckMF8afyOnoDg2RnvW29uRviywJ7CK52vw6OEf8MliPodBdAFWW2mP2YbefBQvzwhmknhXn7YlE9dNGcP0Kh2Xf9NnsqmHs8mIH2u9i0GrfBdGEWsLZ9aibxAzhGbvXpx8sCbClP8ME8jGIa38BCGt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3mjDWnnzDiUm4iqeckBxtuD3JPXyuH/1BhlHuLtBgA=;
 b=CcsvvRdwlhEKV6WCvFn89tR2n2xO5owAw2hX0J99bqEgivyQeR1xqiab34poZ1bk8nem6YywF0hMLafbOCg/yhpjVFNKwf1kTvf8te+QvL9pk3v3axxqMhDy5fi0u4hTs8AaYhsEEAWlyT0b20u5aCVf8ZRRJBVGW/wMiPZ99f2yoPJCymcJCJPWN7Pw9OpARp/e5pn5hdCfgVlbLyVisNqEcyhlYeGSe1oX/NHeg14tYw11ua4FsBd/b56+pFx/ahHh3yj9IWDAW3SqLEyIVZ3bhfktRppNb/we0pkVhtregypmHywI58ve5AgT0ce3aL11oWPJMh5NZm8XgguECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3mjDWnnzDiUm4iqeckBxtuD3JPXyuH/1BhlHuLtBgA=;
 b=x89Cj1k5DCWfeMKFKecKFU1puiEisH3T2pfkap7HJXsJv7JiUIDM2wGkcer7SWboeb+iJOnrdZAjzs1ZRZWkfrklrplzvsCjGBCGiP8iPh/cazw2GrLdXNWdS8aTWvx8Dvn9J5pfptJIpslqcIa9N2e37zNyK5nuP3z/htQVQUM=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1378.namprd12.prod.outlook.com (2603:10b6:404:1e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 25 Sep
 2020 19:51:48 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::15c4:832:a4eb:2f1f]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::15c4:832:a4eb:2f1f%6]) with mapi id 15.20.3412.025; Fri, 25 Sep 2020
 19:51:48 +0000
Date:   Fri, 25 Sep 2020 14:51:27 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 8/8] x86/MCE/AMD Support new memory interleaving modes
 during address translation
Message-ID: <20200925195127.GA323455@yaz-nikka.amd.com>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
 <20200903200144.310991-9-Yazen.Ghannam@amd.com>
 <20200923082039.GB28545@zn.tnic>
 <20200923162510.GB1684790@yaz-nikka.amd.com>
 <20200925072231.GC16872@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925072231.GC16872@zn.tnic>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SA0PR11CA0061.namprd11.prod.outlook.com
 (2603:10b6:806:d2::6) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.2) by SA0PR11CA0061.namprd11.prod.outlook.com (2603:10b6:806:d2::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23 via Frontend Transport; Fri, 25 Sep 2020 19:51:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5fdfa853-9505-4446-0c50-08d8618c700b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB13780AA2B27E856B331FA87EF8360@BN6PR12MB1378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ieUPqurd17TGcPj06Vfdg4uTMM/v0rCPt+CJ5ZZu0HDYvyG9GZf5WBbPq3PmuQCH/UOYFiBS0upBIkKED5OL2FGKhy7sDLthArwc/Q+seubdJTIbnTnQNJSWPQrEgSoeC80PgjZyDN8fNwMJ27RVLS7c/g6Cw8OHXcBkIAVwQNv4/iaXIciR3NFHctOm+suQsbo/8s0xgMBdvfkSDvLhAJVyaLTq48GSGS8KRAHO4SSC/6YS7t/C29a3R5Vaoak5y7tWwl/zWCx75N4PjGQKPqID9rhtRZ4tNsqmIPeqmlcXhQwWCF7DAClLEEDysiPIrIzR03bdKz1Ns4SXFCvjUo8taHZhQI3H0uxsZLZKV+6I79Zgxie3VOai5U5eiDPf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(956004)(55016002)(7696005)(316002)(16526019)(478600001)(52116002)(44832011)(186003)(66946007)(83380400001)(33656002)(86362001)(8676002)(4326008)(66556008)(5660300002)(1076003)(8936002)(66476007)(6666004)(6916009)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0L1TDPWkZkifrNlTzwiRTQ9kCLPuCDpn5QEAXwC+QJUqIAmetsRVAwcR6oXYhVAmzVRX0lLQiAblo+63OJYYiYumyMLEXP6xLiXqL0VVwtIXzoBAkMH6aIhIdAu3aXyYUmiuKSNtaxDZ3L68l8ZgYhF3OP79ZhTcSfDgiAJyKsrS/ORCoZaxV5161BXwajuPlkcBvRr17PGwDSQPVNz6/gtqGNLnYWVcQz+keMSQzOut0xdRAy1Zrizm/H7e9yjgyUbqHTZSQ203XPUscLg48YQmHOIhrG4d1IFTuRomHOpzJmTJOmouyX5dMWXlB82ZXGcWw3C7AXWFx5oWQfrZLLp9Ozk80hQBFEOyUSWoxXfLEBYFKGl/bYtIKnyr/KdHZi32bfs7axAK0T75I//fCYnX979frauiwh3CFAlh3FGW28CzwCzPMc3QK2rEyBISclfrEnczsLey+j4PZbJIChYgXM9GMR8F0mXbmmPwwNwKzJG4G1gyVlu9iVN/juSjlXIc/5Ka0fYhE/i7WX9Q5yjlfcVLIFSeJDU0SqidN3t09TyuCkVD2G0xaY8G+7S4kwye8mc57krqZnuFB9Zw01RdG4H+vVH7OW2hmx42TpoHZHQXnsE56UC/tE+BVDKABUdlEQ54d2s683rWJUPdOQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdfa853-9505-4446-0c50-08d8618c700b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 19:51:48.1609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHck7hmuMBaoxFkbypUOSHuTmcBSPca88erNbDkmshEvaJhJonnIYbYLhYcxkIwOA2egApHVxcyqCKiJx366TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1378
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 25, 2020 at 09:22:31AM +0200, Borislav Petkov wrote:
> On Wed, Sep 23, 2020 at 11:25:10AM -0500, Yazen Ghannam wrote:
> > I don't remember the original reason, and I was recently asked about
> > this code living in a module. I did some looking after this ask, and I
> > found that we should be using this translation to get a proper value for
> > the memory error notifiers to use. So I think we still need to use this
> > function some way with the core code even if the EDAC interface isn't
> > used.
> 
> You'd need to be more specific here, you want to bypass amd64_edac to
> decode errors? Judging by the current RAS activity coming from you guys,
> I'm thinking firmware. But then wouldn't the firmware do the decoding
> for us and then this function is not even needed?
>

The UC, NFIT, and CEC notifiers all operate on system physical
addresses. The address in the MCE record is checked by
mce_usable_address() to see if it can be used by the kernel, i.e. the
address is a system physical address. Right now, this check passes on
AMD systems if MCA_STATUS[AddrV] is set. This works for memory errors on
legacy AMD systems, since the NB MCA bank logs a physical address for
DRAM ECC errors. But this won't work on newer systems, because the UMC
MCA bank does not log a system physical address for DRAM ECC errors. So
the address provided by the hardware will need to be translated to a
physical address before the notifiers in the MCE chain can use it.

We can add support to get the physical address from firmware in some
cases. But it looks to me that we'll still need to keep updating the
translation code in the kernel to cover some platform/user
configurations. So it makes sense to me to move the functionality into a
module to make it easier to update.

The address translation needs to be done before the notfiers that need
it, and EDAC comes after all of them. There's also the case where the
EDAC interface isn't wanted, so amd64_edac will be unloaded. But the
functionality in the other notifiers are still expected to be available.
So it's more than just decoding the error like we do now with amd64_edac.
That's why I think the translation code can be in a separate module with
a notfier that runs before the others. This can do the translation once
then pass the result down to the CEC, UC, NFIT, and EDAC notifiers to
use as needed.

Thanks,
Yazen
