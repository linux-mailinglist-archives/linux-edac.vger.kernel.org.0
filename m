Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B0726E085
	for <lists+linux-edac@lfdr.de>; Thu, 17 Sep 2020 18:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgIQQVu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Sep 2020 12:21:50 -0400
Received: from mail-bn7nam10on2058.outbound.protection.outlook.com ([40.107.92.58]:15457
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728461AbgIQQVW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 17 Sep 2020 12:21:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5eL7oOn0nTAR0eLQcKXoeRNpZKe3Z9Ywt5mMBnkgguVubimCDtS+UrjMHoAhJTU96sN25oO6JCZghSfGOstRFKhSaLKNMRA9xPmaSJ5dJVyLpa7za/zKIedLQy/5loEbuyFNfvADJawrLWxlzyeuc1yXW/95SCxuqyz4UoA8g5jcfdW6BTHjkr37KHHI7tCK1E4E4O2OzK6yru77tTArh2CcnpYGiLYkRcNnSFQP1t3+ItBtsLVX62rLQLGKiVeE43dXsOITgZLpltWIyh9Lux8cJ2edNKqJ/rnGxiOMMVGezmfJUwEKyg3CbKVddOTnFltUhHMdO41enMUbaVhRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hw6wEMdGGccRmOQG/1q7saG85idui8HbdURexULl1IA=;
 b=YlvSotXKRFtB+oZhmmMOK9SwzQRArgcq9PgnXaLeT4EglusnQZrtyIojrGFQT+jTp0udaepkC9RxeiVh4POlNEL7uCkTtJaEAVjrX3MwxguL7T/vDL2CRAQppaNb1+ryBHBjognKIOov5egqbErKwXee1o/VocrHhOGgHxaH/v9SgexRknYBcGkk01q7m1aRKxzaRD77+6hYMDDhj3eG4uz7rQiL9Fce+yW3RExYuC54qRobGkJ6kIraTwAWi6fQ2oV28fxKroLYhnZp1Z4t4r7s7fIYTcom8ZSo+4V2TBmHZQF9raKkHndn96wAfGx6dFbzEavG7ljJSKQJp0ijZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hw6wEMdGGccRmOQG/1q7saG85idui8HbdURexULl1IA=;
 b=y7LiMVV5SIWXTF+6V7sbiL1W6isl+uxq6XAf+GC3Zj2BI0KYazE5+sQxvtawJ2ptU5VpxbtT93nKidb7504sgF8bHll9sB47+ZRZnDPB4h1Ck0qiPx2H8lmQITJr1sN0X2QC0iYPv7qG9GjqQjq/u8fhgFJ6P30p8FbTRJqTMbM=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR1201MB0212.namprd12.prod.outlook.com (2603:10b6:405:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 16:21:06 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e%4]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 16:21:06 +0000
Date:   Thu, 17 Sep 2020 11:20:53 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 1/8] x86/CPU/AMD: Save NodeId on AMD-based systems
Message-ID: <20200917162053.GA234735@yaz-nikka.amd.com>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
 <20200903200144.310991-2-Yazen.Ghannam@amd.com>
 <20200909180647.GF12237@zn.tnic>
 <20200909201755.GB3014671@yaz-nikka.amd.com>
 <20200910101443.GC8357@zn.tnic>
 <20200914192039.GA39519@yaz-nikka.amd.com>
 <20200915083259.GC14436@zn.tnic>
 <20200916195152.GA3042858@yaz-nikka.amd.com>
 <20200917103720.GG31960@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917103720.GG31960@zn.tnic>
X-ClientProxiedBy: DM6PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::34) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.2) by DM6PR17CA0021.namprd17.prod.outlook.com (2603:10b6:5:1b3::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 16:21:04 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: baad19e9-2555-4bc1-96fa-08d85b25ad57
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0212EFC0787A8C03A14FD121F83E0@BN6PR1201MB0212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NqUW+1Co+qlIqboa5jL5kmwnOxWcPOYLsMEyqzdTf+dd+uuSwtDkesFvYHA3yS+GP7sA9uUKe2fxJXgEz36O64tc2cmFlerkvPseR6Gk9zkRNkIuvBuJi3B+aKpLRR8gTuwHVtKPzFAZOL9hTqD+lj+t50x6J1laH0Yfx6JmYW+uWKo8aqbz/kYiKfuMQpQ8j4skOEtri434CQdWpaQoqEKVb/ZYwYaTrxkv900WpmP0yNzn1X3LPyoeRaU00zaaLkm+QrYJw7ymwXzEyIJgFNGzJxFk+JcrzfUM3ai44JvjKWlFI2Zfu6OLm5zTVuVJeeKbmuDCS46Gs7rJapVoxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(44832011)(5660300002)(1076003)(2906002)(33656002)(956004)(316002)(6666004)(26005)(478600001)(55016002)(16526019)(186003)(83380400001)(66476007)(4326008)(66556008)(8676002)(66946007)(7696005)(86362001)(52116002)(6916009)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: thBWmLdMuoUi8wGkAVwBuRYT2ixz5jOTQH/S817IlZipmYYi3jDRJyInn/WyXADlgTp1FEKJTlVCHYTvkQwh8A8hYggHIoZO79+PsTTRU9xN9wzVc0QGITe38DFbM5dg0ZFQNCfxQiuPkMnVICAz38yucTyjc9tuTnKj+09CKeHDT3Qe64G5JHyGiumLYPbWps7M7+CkOScvRZfh0rZ5WFlFOZChhxpNp+EEieqnxRdmtai++gF+Z8H3581Kju9zvi6hMW4iGOjoBF9GDNYgFx+wTKv3a5oxmwGCfJGT3NT3wkwjSaRI0jJzjYMEnhBI/h8b9xanQClI9FPq3CQI6QHQWUv8yP3NN/ZjGwOkDw+zolHZC/zdw8t4hL6YBGMNhDxQHwMb94y1iTFGCAS4YKabWsYPBdsFOU7peVb42Zd6ApGw/ctjo4AMjE9Ejok5i1y+XcI72K5e8Jj5a/qTnH8Mdy/86uGQFossaQT3Oeb/tK0Pmd1SpEhhER4jxfzhHckB0WsAiTt8GoGLK/qrrThnJfnmV7O5JJuOXRdNaV6o5zHh/rU77tpWztQGFuMtt/b4LozIkBQHM6SZK2RFIUYbLo224S0wY8Y0NiVKpfcVvKvYCPXFrB4zaKsMvLszs3mIUqPCnwo1QgduwCY7og==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baad19e9-2555-4bc1-96fa-08d85b25ad57
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 16:21:05.9997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFxFj+q02CXn2o+JnrG8SY9JxsIgZ+chMMB5U/Yrq9RJ13NchtTZlikqO/MjH2YoLm97Z2mauoVp1hCO7uLLpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0212
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 17, 2020 at 12:37:20PM +0200, Borislav Petkov wrote:
> On Wed, Sep 16, 2020 at 02:51:52PM -0500, Yazen Ghannam wrote:
> > What do you think?
> 
> Yeah, forget logical_proc_id - the galactic senate of x86 maintainers
> said that we're keeping that for when BIOS vendors f*ck up with the
> phys_proc_id enumeration on AMD. Then we'll need that as a workaround.
> 
> Look instead at:
> 
> struct cpuinfo_x86 {
> 
> 	...
> 
>         u16                     cpu_die_id;
>         u16                     logical_die_id;
> 
> and
> 
> 7745f03eb395 ("x86/topology: Add CPUID.1F multi-die/package support")
> 
> "Some new systems have multiple software-visible die within each
> package."
> 
> and you could map the AMD packages to those dies. And if you guys
> implement CPUID.1F to enumerate those packages the same way, then all
> should just work (famous last words).
>
> Because Intel dies is basically AMD packages consisting of a CCX, caches
> and DF.
> 
> We would have to update the documentation in the end to denote that but
> let's see if this should work for you too first. Because the concepts
> sound very similar, if not identical...
>

Yep, we could ask the hardware folks to implement CPUID Leaf 0x1F, but
that'll be in some future products. 

I actually tried using cpu_die_id, but I ran into an issue on newer
systems.

On older systems, there is no CPUID Leaf 0xB or 0x1F, and cpu_die_id
doesn't get explicitly set. So setting cpu_die_id equal to AMD NodeId
would work. But newer systems support CPUID Leaf 0xB, so cpu_die_id
will get explicitly set by detect_extended_topology(). The value set is
different from the AMD NodeId. And at that point I shied away from
doing any override or fixup.

Thanks,
Yazen
