Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BEB26E596
	for <lists+linux-edac@lfdr.de>; Thu, 17 Sep 2020 21:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgIQTyl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Sep 2020 15:54:41 -0400
Received: from mail-bn7nam10on2077.outbound.protection.outlook.com ([40.107.92.77]:32147
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726565AbgIQTyj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 17 Sep 2020 15:54:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qnzj5bC2wigNOA+PTNqvLeKN05D5QzH64ZCMB+vYPlVRI0krGOGW0toOZ0sVZ3fsHjNraK35b8X6lX0z7yGAEI4vCAqUDodwYGE9oTzCAHp0ZvrRFfiEYSOnuAF5KvtoO80Wz4vZV2EvOsdQVxzL7Rzl7SFj/ZVfD31IE25s6XVjBQNbpKXIWOn5DYJJcVYWIQLboVMKoJKoNghYGOHt/GL0ypW/c4UVArSKjN03S2yrWp5odbr4F7w8CoDLH9lFVFzoadVGQsysQL8L9YWFZKBndYebB338ZFSoLQwYBAb8rACmV0NSTD7+51+iu85t2UG9/0a2fPlOxezCjkrBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0dryGsPorrpmyMmVXczthE2VmZ0secGXqJ/r53KVlw=;
 b=lNCNZRXY+difor2HHyUidIuqSQ8hNkiE4mWvr/V/ngnFD+4wAjrxPEZNLOjQFuF5VKZmjWDMUyeQZr2jw+O/4EnuIJTk/+ywQKS4L3fpDgmfoOfQdi7WH5VCyNNrK/05ReSMqUBQG9862qdr3yxP1IV3+ihWrVXZfoiJ+vS57x7Wv7DIgkDa4nZyEy5RhOrnpZxyDe3sAJSRdwWksel2H/7x4rg5Ohbw84gA9j8UjQm37g/4Gl/4u+ATlGwOb7GA9dUq4rwAOuf1ROVxkuUDfqmkLFjSwnEBNWQO00W0MdkAbDVfepw8WUzH457jMeP6H6YXYAMmq+LkOwr+uXAHig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0dryGsPorrpmyMmVXczthE2VmZ0secGXqJ/r53KVlw=;
 b=ienFakuFDW+f6P09Gk2ZExIar4hu1FC3BoNVc5BzMWVTtNSjkrcubLS6kxTH8Qrpqc6aVbNcJ/Px7gC6qUqYGWGsnK/N/myx8IH5HGVA+mCZWYdX3a1D1sg077wUPtOtbf9aKEj3XXdCaAamo2cd5M3zWybI2b8Q3grk4QNvfuI=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1572.namprd12.prod.outlook.com (2603:10b6:405:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 19:44:33 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e%4]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 19:44:33 +0000
Date:   Thu, 17 Sep 2020 14:44:25 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 1/8] x86/CPU/AMD: Save NodeId on AMD-based systems
Message-ID: <20200917194425.GB504453@yaz-nikka.amd.com>
References: <20200903200144.310991-2-Yazen.Ghannam@amd.com>
 <20200909180647.GF12237@zn.tnic>
 <20200909201755.GB3014671@yaz-nikka.amd.com>
 <20200910101443.GC8357@zn.tnic>
 <20200914192039.GA39519@yaz-nikka.amd.com>
 <20200915083259.GC14436@zn.tnic>
 <20200916195152.GA3042858@yaz-nikka.amd.com>
 <20200917103720.GG31960@zn.tnic>
 <20200917162053.GA234735@yaz-nikka.amd.com>
 <20200917164048.GM31960@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917164048.GM31960@zn.tnic>
X-ClientProxiedBy: SN4PR0401CA0042.namprd04.prod.outlook.com
 (2603:10b6:803:2a::28) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.2) by SN4PR0401CA0042.namprd04.prod.outlook.com (2603:10b6:803:2a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 19:44:32 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3362fbb1-ba59-4ac1-db4f-08d85b4219d0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1572F76C3B2418F673F455CAF83E0@BN6PR12MB1572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1x/1CxaSNwBhY7aadcslixp6VAlLIMrALoSY/LigtY5oD/9WusDjeuapZNcVw3yYnkbS4V/5oZTwuDSlvHTPK/TVWOf8/7y4Ae3r5UI/2I5h0+7+edXFsjmTiOi7ocSRxdEdwBje/NE2W6tQzOMkS4ee9oAH6onQ3kZfOycZuUdzfFtdLhTjRqjuN2kPoDmSXPM8uyzIYT3TmcGkLMxwOSV3mD7u01oQ7nIaczRU+IW2RaW4fyi1BuGyI0WSUp6YizNAPP2TypmN2pzrxUtVQ/h6hBvYWMD5sVS/NYRa7h+8eMU/VbhR8I6s6i6rdstgTHXdO9eSD6KTsWdoUVPEJLUXyMBYU29qKQiOjFsJLPJdYOR0BYHA9ZwoL9wFMrc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(8936002)(83380400001)(4326008)(66476007)(2906002)(6916009)(66556008)(16526019)(86362001)(186003)(66946007)(5660300002)(956004)(55016002)(52116002)(478600001)(44832011)(316002)(26005)(7696005)(8676002)(6666004)(1076003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 13ZpMWaCsHadj2MYqVMqz0PTkzUOXwoAOz+XiQyHGVtCQPXrLqYWKI74aHuQd4CYs9g5SB7cQH7kbYyG1LCPrfrlTi4sHJL2a3mlC/PSwfBGiX1Gb858SyN/ptlA7Lf2Gabc2VtzRDbq31QDqyMkegwXKCoVeC+HJM/hUK1ecBDNQhOVv/iB+4sFj9yI8lHeV6PucPHFTAryotbjXnOjYqOUmIDnvlHy8G2BvUvZQ8ZuJQSjLF32mbYx+dln5VBfOR6SJhXQi8q8UwxpEWSXxKtypKhMXTapFssWU8jEkf3CuyUz7Ni1LlYindY0DaZagnrulw1imydwlgfc4YFhBE0FDkFN1sNgQziNVSOQTrusaUfFguuQMblApZmH55t82q3i+scOYAPKJYCChUtXOE13liinTyZOndycV4jQUMm+ds7NxQWJDdJADDDzPDDrZhozMMp+ZXUdRrvR9KTdvkVIy+JVjV/TMm0+xgV46eFrzwOw7mAhMkPYrO5nHtQdk09biscrmOTrLuIYlfat9YEje+1wuN6+EqSBX6zehS68/hHP/ES77CrVyhc3DUhy4dSIqJIObeTwvrdgl+V+i8KIL4QEzT3slvpZOMeHFMOH05ugNRMz8hNaUA5eeTpO/rFXY+g+aCJBFhL4dUfsiw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3362fbb1-ba59-4ac1-db4f-08d85b4219d0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 19:44:33.7739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goIMuPdrvNvYvJq3lHC1CBJNlV0ikSageuKUgYnKCqawD0D4AZArddONaO+IbScTFSlD50bwXd0WswmJb9rK5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1572
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 17, 2020 at 06:40:48PM +0200, Borislav Petkov wrote:
> On Thu, Sep 17, 2020 at 11:20:53AM -0500, Yazen Ghannam wrote:
> > But newer systems support CPUID Leaf 0xB, so cpu_die_id will get
> > explicitly set by detect_extended_topology(). The value set is
> > different from the AMD NodeId. And at that point I shied away from
> > doing any override or fixup.
> 
> Well, different how? Can you extract the node_id you need
> from CPUID(0xb)? If yes, we can do an AMD-specific branch in
> detect_extended_topology() but that better be future proof.
> 
> IOW, is information from CPUID(0xb) ever going to be needed in the
> kernel?
> 
> Also, and independently, if its definition do not give you the
> node_id you need, then you can just as well overwrite ->cpu_die_id in
> detect_extended_topology() because that value - whatever that is, could
> be garbage, just as well - is wrong on AMD anyway.
> 
> So it would be a fix for the leaf parsing, regardless of whether you
> need it or not.
> 
> Makes sense?
>

Yes, I think so. "Die" is not defined in CPUID(0xb), only SMT and Core,
so the cpu_die_id value is not valid. In which case, we can overwrite
it. CPUID(0xb) doesn't have anything equivalent to AMD NodeId. So on
systems with CPUID < 0x1F, we should be okay with using cpu_die_id equal
to AMD NodeId.

I have an idea on what to do, so I'll send another rev if that's okay.
Do you have any comments on the other patches in the set?

Thanks,
Yazen
