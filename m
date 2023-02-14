Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934FF696792
	for <lists+linux-edac@lfdr.de>; Tue, 14 Feb 2023 16:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjBNPEy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Feb 2023 10:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjBNPEq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Feb 2023 10:04:46 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91705869B;
        Tue, 14 Feb 2023 07:04:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCv/8o44CT10lFbm1TxCZAFAXpMs716UiA72kaa6IizBrL4Z5s9G01F52NKEVYKAetBGn47my4ZYw4WQ0Hrn/i9Wah0Y5oZqJPq8I1O86ydNcOWL8cfrDfxN1oPQu/4goVoFfXZs26eNx5mMEm7gD4K6rtyvJwsANRESCN7h5Vvnqyy8Aa9ZQlMlsZvVeEIbeA1Jkh+oOpJBTgFgM3ygwoPEcn2f0ow5grYwA6mGqihCirUaOJp3+2UPLI76qHjGAcjirymN3+8fybveSXBsXYA6Xr7G2lBewwLcEvFYDaP47iYgA0U3DdIH7FqsQlUmg3hPTn+kxK3F6rdgu2qb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KyMhC/W4UcTj8J5ktKDQ4H5fR/ndHk7sXyYwBvoq6o=;
 b=ARjq35wgw2NwOXIvVOVEVPlCdsIKLhs2qHfHNKymuHsllhBxyI3ceTDJGiA5TryakXA9VEHkP97yU80wI/jAlaxEREb1AGZZAiPQyJ70RuxbkcFRQ480a6tcJP4WJZmCUUdPDQEXgNtUEYR0FO1f/Cnkt8JOJtsLZXN2ewgOOqqaVOoTwDx3wz83kxXgRC7IpspplzOw/Eom8kWGL9SlzhLY8DbhoVt1wnXa9YeMZLsaA0hTQ4bGTFAeO6s73MJsjlWGsJl/dG92ShIHlDILKZBwLBQiF15RVbHjFhczPxpR3rWbgEbkNY21ysgoq/9B0HPPdPUlZXo4ziM/Df6X7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KyMhC/W4UcTj8J5ktKDQ4H5fR/ndHk7sXyYwBvoq6o=;
 b=WltShnInVAPanpiKYoTrF/Qtm69haZESdl9zYuwXemtzu4jnyCRD5Fnnn6vE8GP7WPMPyHzC4kSMoBsb2AWFYGhaylyfzVUktDRjWW4JsyqDgjJGo993oSyZzCySqc24D82IqzHfZf47ryaj5vf141BEOisaR8TtQ5oJKK1Nx98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 15:04:42 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::8a66:1432:79ca:52ff]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::8a66:1432:79ca:52ff%7]) with mapi id 15.20.6086.026; Tue, 14 Feb 2023
 15:04:42 +0000
Date:   Tue, 14 Feb 2023 15:04:35 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Tom Rix <trix@redhat.com>,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: Shut up an -Werror,-Wsometimes-uninitialized
 clang false positive
Message-ID: <Y+ujA+Kr05Adky1l@yaz-fattaah>
References: <20230213191510.2237360-1-trix@redhat.com>
 <Y+qZthCMRL1m0p4B@yaz-fattaah>
 <Y+qcU2M5gchfzbky@zn.tnic>
 <Y+qdVHidnrrKvxiD@dev-arch.thelio-3990X>
 <03b91ce8-c6d0-63e7-561c-8cada0ece2fe@redhat.com>
 <Y+q1mhrAKTobp3fa@yaz-fattaah>
 <Y+q2pXYI02qAje8N@dev-arch.thelio-3990X>
 <Y+tapzerW7h9vMvp@zn.tnic>
 <Y+ubhHlWFv4ifmGn@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+ubhHlWFv4ifmGn@dev-arch.thelio-3990X>
X-ClientProxiedBy: BL1PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::7) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SJ1PR12MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: 13236e67-14bf-4e03-9555-08db0e9ccd43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E+MUhuP7bQiJg3EaEFkIjGtpg51hq8v+EIqCyZQSTaKMWnOFQBUaAr5H+bRphsWewwGYV6QhzdQA4vn4/Q6nuJvgUsKw8nfGnVw3ClRF11zBzMOH3Zs3PilhKtMylGqLH2M/Bw/ErI7MDg1M+XLSiTyEJfC6Ad179pM/6wzUB9lTYxAdIrjA1yEs8wGe3rPhi2amz1Uxan9+IoFwfjyW3ouADO+kNIOuGYbJH3M3TLlcwBAq9SUUSJ9jNZYDPLTp0IhJz2rGzmABgYNY/+zAef4nYb+vb06N1TiLh9Q1xAO8f/HIRW/SU6bWg2e9f+bPodBWkyHH7FhcSADEHKBRiMb8BTi8dJiwLfglV4jPq1SicF/CwO/E1mTqNfnfDS0ROJWyrJf1WQihhZsDJLxrlAt1ki1ivGq4sqdciO4JmRU1Wc3QlRQKMdpRXLHxVwFKqtSpxucS95GIozwNew2FU3ez0Y3/kjNov94kQXhOuaF6wM7X88WG73lB6axOJRORxKHV/UE6+I9r1+gg3jgW5W9Z18Kc09CzsEBsyKUT1+kjePwBTS11RBwPR43qdChyPguqWBsm+wnnS2dmBxtu32981SoCsVCbHAtln6QNwsuPS7CGF51QSn+aSVC2v8fd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199018)(66476007)(2906002)(86362001)(5660300002)(44832011)(38100700002)(33716001)(54906003)(4326008)(66556008)(6916009)(8936002)(41300700001)(66946007)(316002)(19627235002)(83380400001)(6666004)(6506007)(6486002)(478600001)(966005)(9686003)(186003)(6512007)(26005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8nDUepJ1XQbDBx95UzeVcZsKq7PDtTQxA0eD9QSnmWJ+wpSjHvnBqtVT/Oob?=
 =?us-ascii?Q?zTK41SqQLmliUtPxTQqr+WoJOKcranVKqeKnNA8S3ujOUEk8n/BlPwmJcfJj?=
 =?us-ascii?Q?0u9HZ6V90h/40++utkZHFhvCFttpE8XMZ2S0k84bgKOPyM/tF36mGbp4idVo?=
 =?us-ascii?Q?0FGIdenKKpQd+ZhHgqGg8UkeLMrp1v1zyY0ds1LFMo/Z2nJx3+MeyiYIN71u?=
 =?us-ascii?Q?nK6fJUC2GQsOuf4705uPWEDIGFLthccms14W92GCcaWvEeUVH2lCIfA/zsz3?=
 =?us-ascii?Q?SEYgq8LifI837n16NmTyKNqp/piDM9OlNdreipfQILbCIJhRsvqzs42XsjRT?=
 =?us-ascii?Q?R3xZMDujm5cloc42BQwy3SHWQtygvPZTyELGF9qogsQtXDjbkUtE4eUgs+Zw?=
 =?us-ascii?Q?VDnaJIJrxLB4QROgrOpEqSkHn1tOU3SK/iNbRuqiHlD9M8tmjqrR15dULBJp?=
 =?us-ascii?Q?yahuIW8QO1i25BWCSbJa3JY7+6HEoB7hQwBVyGaKUog8ylVcuYMdA88MWmnV?=
 =?us-ascii?Q?P4jxoTjgZ/HWnNg22SEQd+79w8KoScE9ZT3tmCTFHUxEj2x0oUsDBOPSrTV+?=
 =?us-ascii?Q?caboTRQ9+eu1ULbQ/Ghu76F7q40s0VqAITZ4MfJvluUy7chZFxDkrS1nkBH8?=
 =?us-ascii?Q?Qf/sA/A8vKFzPlONZtOTaSzn8GVvDQ7n+aP836JY7eXm/C2diAqb0hcbBSWl?=
 =?us-ascii?Q?I8iy1RbI5/gk3SRpIw1+v7ahptUFCbWr8IzyGjXFLvh9oHYVr8m8MZQ9b1Xn?=
 =?us-ascii?Q?Bmg3o5BT5Df6aPeGruxuo0ZTPeZOm1yecc4qpvG7sSlwXn/u/GvjOae3oNsM?=
 =?us-ascii?Q?ppJS4fGEGRt9x6xx1bQrY4/yGG+7xZ6/hBWuS7lbu07rPLlMN3Ymk70VYm5q?=
 =?us-ascii?Q?CBntbhbFz7kAiWDoyjAEq+r+BDExj/Ir4BPDjnih6Iehg+u5nS83udt+cnWU?=
 =?us-ascii?Q?vJ0cU1GFJiEAqYjtJ+qWhAS2LxxuzCcGspYAlrfEqSWN/dsPKGCm5x9x9dPx?=
 =?us-ascii?Q?SPnH190Wh+fgw+fg7FHOiN+zRKBmPVRNE0clw0cAZqyxwyJdlxuZb2BX8VHA?=
 =?us-ascii?Q?DMMk+72FScD7fTlDlZcKrZlHF+xUWjppS/9VUzRH8Ce/Hn3PvJRdv8nsIylA?=
 =?us-ascii?Q?A2SUXVJLiZLCaN5xxQmCCa2tVuOfb6msgH5Kh9rSZ9fy7A2lWSZZ0WlQvEoH?=
 =?us-ascii?Q?WUcO8doVw0vT4vno/8BzSmLoD/vJ0cS8pWcmDzsR8d7lEy/P5ejyLM4qQ9qF?=
 =?us-ascii?Q?ydEuniH/rg3s9AHi8Vo7V9lVMksm0JJpHYqcKd4IGxo55pg64v8fPLQIio/Q?=
 =?us-ascii?Q?akFSTqi3OjheczQNsaE5Xegl1uEJxNG+kMxWgHEXZJyheHDUEqxFX/h/iW2C?=
 =?us-ascii?Q?mxYRW1yPgX97DMgob7Bh4mpcbJ3I2RBykTdYQ332OSMm5U3y4xFO9aGUVaQE?=
 =?us-ascii?Q?vn2SrNO/IiDfdDsiIRZYvXGe6RO/ORqymJHtPdvotHqAyj7iJhFE40KkXNHg?=
 =?us-ascii?Q?c15O3Bjxpl77MqpjP2H3sB/jIM+JID35oFwtqKpYMwbsTdEe+r4CeM33sT1L?=
 =?us-ascii?Q?EYcFEfW7vtEsoU4JMFkJakO7YD+XUzu4UQjTIKKw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13236e67-14bf-4e03-9555-08db0e9ccd43
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 15:04:42.5908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoHIDUrSXtW7rk5j2wRYx6bH1/P/1EAexeSsu2MZD/IRjOpt8p9z7x50EfF0Igl7qh9p9Mvxrer9Z9axyyumww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Feb 14, 2023 at 07:32:36AM -0700, Nathan Chancellor wrote:
> On Tue, Feb 14, 2023 at 10:55:51AM +0100, Borislav Petkov wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > 
> > Yeah, the code's fine even without this.
> > 
> > What this is fixing is a compiler which is overeager to report false
> > positives which then get automatically enabled in -Wall builds and when
> > CONFIG_WERROR is set in allmodconfig builds, the build fails.
> > 
> > It doesn't happen with gcc.
> > 
> > Maybe clang should be more conservative when enabling such warnings
> > under -Wall as, apparently, this has an impact beyond just noisy output.
> 
> For the record, this is the first false positive that I have seen from
> this warning in quite some time. You can flip through our issue tracker
> and see how many instances of the uninitialized warnings there have been
> and the vast majority of the ones in 2022 at least are all true
> positives:
> 
> https://github.com/ClangBuiltLinux/linux/issues?q=label%3A-Wsometimes-uninitialized%2C-Wuninitialized
> 
> So I disagree with the characterization that clang is "overeager to
> report false positives" and I think the opinionated parts of the commit
> message could be replaced with some of the technical analysis that Tom
> and I did to show why this is a false positive but not one clang can
> reason about with the way the code is structured (since the warning does
> not perform interprocedural analysis). However, not my circus, not my
> monkeys, so feel free to ignore all this :)
> 
> Regardless, my review still stands and thank you again for the fix.
>

Thanks Nathan for the feedback and thanks Boris for the patch.

Nathan,
I see there's a ClangBuiltLinux/continuous-integration2 project on github.
Is this something developers should try to leverage? Maybe just fork it and
update the action/workflows to use test branches?

Thanks,
Yazen
