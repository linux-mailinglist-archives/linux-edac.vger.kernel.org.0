Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD9160D1AE
	for <lists+linux-edac@lfdr.de>; Tue, 25 Oct 2022 18:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiJYQfb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Oct 2022 12:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiJYQfa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Oct 2022 12:35:30 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E057E328;
        Tue, 25 Oct 2022 09:35:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6XPcFpb/AQYsb/OyYklUXC/5JyPHe8YcwN5UBDiNnu4irEakUAU6EDTHobPyA0HGjzMMTtjt07ucDd5uOcWfGle7ByYMVPM5Nv1cliafiYHWMdkiuL2HRUbB0FU7GckQRWCDUjDePsICWzPeKwkej17JBRlb7wUJ9C9kU+ZP6QqQi7UIligNV0gfU8gq0a4smyA423xK+bzmp2GmsJM2qSDA4WO19bkyAWoajQyYWAve056B29MS9lCXPwONQLutwvi6txWcb9hYWGn7OPksIKht7EFWwaJEBA9HfwIzsVMTAtM9l+nn9FyFZwliAe6evcItRoTDGdVWqJnDE7j+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CCLp3rXvY4pe8g29UDnzJNOUIbqOCkY5jNpHKULb9M=;
 b=SRhZwZFD+qre704az1wOdwOmEx3ada7Wx2q4Pm9Yv1Szw6fIqiWRomY7ZkusjlN8i1hcbGOwsofumER1MCLWaFtW7Q9+yrPgjbKzbTKYv4X7fMU8quAVF/2HcEKOm+2Q+OltuKL9aehsq69reN0pQfnwD1D3IEQlLsyFiJ+L5x1Oe70+//lkbJMYJAawYe7rVTi8NQZEk+h7Dq7Agnu1GYQKRubg2lbrnExz7MykCOHf2+IsxhkhGZS7L22kIvKZW67R/XyTJCrkNJ3B0WzS7kwQe0W/NvzyEyAwOqdX2MKX0akhrxkeNhCKCwzTQajIbWbtyILPKwY0i8FaGI/H7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CCLp3rXvY4pe8g29UDnzJNOUIbqOCkY5jNpHKULb9M=;
 b=bRa6FQX3WCni7QVq/nfCSyeVSgpKr44CVQoDcbr7roFhJ60cJc4LnV/Jp615uw19ERBGIuf6m1chY2b6962kfn8GVsgVONhEUEOt6JfY0V81BKCdAUGs45gJXAXyXDYNY5xQU1dfOh5B/zLUGAAMpfA/CO0nuIyqT22KuBSwlOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN9PR12MB5383.namprd12.prod.outlook.com (2603:10b6:408:104::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 25 Oct
 2022 16:35:23 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ee94:4f22:751d:278a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ee94:4f22:751d:278a%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 16:35:23 +0000
Date:   Tue, 25 Oct 2022 16:35:15 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Message-ID: <Y1gQQ8gh1CJf0Tuy@yaz-fattaah>
References: <YtUgb2Y/H/Wq9yIn@zn.tnic>
 <YtVlNrW58cFmksln@zn.tnic>
 <YukW/IltcCRwvSM4@yaz-fattaah>
 <Y1a4prRIYNw8GIkm@zn.tnic>
 <Y1a/lCVnlTMk8p75@agluck-desk3.sc.intel.com>
 <Y1b15vnE/Pd1U4r8@zn.tnic>
 <SJ1PR11MB608390D539CD4B405A195344FC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y1cCU9UqGG7nl8cy@zn.tnic>
 <SJ1PR11MB6083DBDAA90E1E03EC7A9EEAFC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB6083A794C876D6F44E530CAFFC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083A794C876D6F44E530CAFFC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: CH2PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:610:54::39) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|BN9PR12MB5383:EE_
X-MS-Office365-Filtering-Correlation-Id: eda72797-07b3-4f8c-527f-08dab6a6ea06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5qraapTZNVhM+XXJrp3kHxp+Tbe3+bDkyGBEzqeZ8taM7IV/ZnfhhDdcC9XMmcYfW+M4QyDsoiq3h69LjXbqsLZlQTWSCm36Z1aipHQIsjUbHfdv5C6KjniFlv+Lwpg0ol9RyPom2xDJX/KIJsSpoeGldKSNNShgvxeG+E3gTJyvp6DVUCRl1/qZhsdc1RmERkD6C9bIGDjXahKSiRVGqef/z0/rcaPvwYS9OjPVg3T3IDNRsmknSaRTnN/ZGGQuMQGqpe5zP20H1NXjuw2cwZKzeks9ahZ5JVsKOtaEg//HOCWJM6W/PlImxP6W4D4qCI21HPoItcWtrhB1F0ZbQMZACYZIUPs32+VVqSrOs1USJqV33cCX4Ay3Glr1SysAV42LW1QvyyKUpx515gPUsww0RBKcn3vD5jTl8amEiFR+xIn10AgkCV0IF3sJBwCwpBOI/YEHQ+Iz3cbhNZuI6S/NWDOJY0gskWhOJ5KN4o+rcZFvvcvl8Gfzvn3sEhN2rw5+Ol+1BVa0QDivM52e0uI6e/NuSEXV2qOW5EJIHaEOMFul/iijGvd+nc8piJ8AIBksfdvu0juDHdqjAUVKOwNN4rwr68kDYNZwikgbBnWthRBk2ut6m+3PGMW3D8z1aQiCiA3nItZUYSbbCX4GNMaG1ZaUFYtDBpxsqzX0g8f76jL/FZxgBCMWwfM8xuPfiZXvnu5pF0lIZRxazjY9shuhxWx+U3JPaF5s1Ue+7DvRfPFnna4uj8Oyfxo1T8zfbVUFfyHaLHh7oGyoL/FqPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(33716001)(38100700002)(966005)(478600001)(6486002)(8936002)(6506007)(4326008)(86362001)(9686003)(316002)(5660300002)(54906003)(6916009)(6512007)(44832011)(66946007)(66476007)(8676002)(6666004)(26005)(83380400001)(186003)(66556008)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2tMegVhkNgjEJCxqeykfGAE69b3nwl8KRS3+ipTupIspKXUdGJN4zJt46SHz?=
 =?us-ascii?Q?ONIRm0lWB1m+zOoKIUAnQcrEPl/qRu9qLr9w2G8UdO+fIBs+ZG1kpxfBpXag?=
 =?us-ascii?Q?If59946smudYX5R+4SJH21ln4kf1yElSCtNaegU5/z3Gs0H4Aokw7FvTKBPN?=
 =?us-ascii?Q?LA2D+WaEM/9ZF5VPE+OTLw1277kEupftGdsQH5hHnQN17iv32FbDKGx8jzz4?=
 =?us-ascii?Q?WiCFZdXbF/l+XpY2C/tU3CVdHcu3PQD22cgOr/quyX+AgEbKLdOqbU1cbHSl?=
 =?us-ascii?Q?ZlYSf7DvVpBG40kcKth8MMEHxGmq1xyiBt2RbXCMEsYuTWFYPrySmdK4f0CQ?=
 =?us-ascii?Q?fkNFhLhOPI2X/DwaI3CxlWpovErgkLxBXcHjvdaAuBoYhNwHqsicjPYUBVs3?=
 =?us-ascii?Q?gOwfbbJ6e2yDaAfK4nwNUlBkj0vv654/K2a2degg4zfSAzjF3+Cq02TiTnXn?=
 =?us-ascii?Q?7aPGRih+AA5j6pPn/wTo6DbLCeeqhzT2mfExGB1Gih9xgylfbneZK8OmFJA0?=
 =?us-ascii?Q?0MrqoQWkWOJDkj4LVcLiFNJtBLf6PYJUOuvt97HyAinPIDSTxBk90tkfUMOf?=
 =?us-ascii?Q?YAlBpBdQBxXL8xoMPKEYCo46iO7Bvdd1vraviTjGWXcKJco6uqQYwRGzOltj?=
 =?us-ascii?Q?ZpbphMlf+xyXdAULQGCITguItJLHzj1iTXG8nBXremZN2bAhw2PEzlku+aCk?=
 =?us-ascii?Q?ycdPrhgKE0PKRq9lBho4GLcyA644llRk4rILls7AMlVXXgR+aBsp7tG7L25g?=
 =?us-ascii?Q?DWHnPsuigbSJ2CXy//AKmDj9NoI/W62TK8UH3dEWt0RY+QDU93Q5sTCd4Qil?=
 =?us-ascii?Q?cSt2MqFoT/6reFKANLOYT36/2sRi8pZ6r0eTBfcgzcnppCmpQWn+hqiZSUw6?=
 =?us-ascii?Q?66iceyviwzP+ZBm972zlR6JHYuKNklW6s0p8T8jTSN/JjgR+NPCUyB5If3Dp?=
 =?us-ascii?Q?CODAX9aU5+DyRqJR4TzknatbS28/ul8taAl/yU9w5XytYwbQXBPUYm/ELqyd?=
 =?us-ascii?Q?/YjPXAyZX152QGRcWz4YeInXY2m8/xFPbBdxsa+ZbUmOjOZq+IW/05AAxR7h?=
 =?us-ascii?Q?FeIcKAbuc0s4aUkX+Gre1qsj6FLL68DeOnuSeu64pFGMgX3tC3WwiFeJSbQl?=
 =?us-ascii?Q?d2clzECV9I4GDEhvqn5CVNz/H0Z2fHbYQCpXQKCPTliApzFybiMu0ty7AHX4?=
 =?us-ascii?Q?vrhow9COvHt+7JG0JUuxFUyzpVb/iQYWf1ZmZ/r9ICjKsHLpucN99/s2U+Q4?=
 =?us-ascii?Q?15CW970FPejoW22ypk8sjvlq7NEtuupV6uQ9bPaz6iI2ZrPcXvnpsHSPMGVq?=
 =?us-ascii?Q?ne5U3wQcsc/ilnqOMIISqTv20mfgGqP3/jOfifuygsjqYqx4fom29CSCT4OS?=
 =?us-ascii?Q?SRnlgil/uLkBN/rmbODjh3popY1Wpwo35EEP0KrE5VrN3kHtBS4TeFgg2iMq?=
 =?us-ascii?Q?xagv1iwFTuaMNtWfxRmK+mV6tdhBX+CY/TJXT8shkoo2peseG1BAwzk+5bne?=
 =?us-ascii?Q?N9Wn7R20ZWoUG1LWV11nEzx7u0RM8pqE+bJ6doYNfxkt5etqsvWLGiMNl3if?=
 =?us-ascii?Q?XXW44ECDFMLTi0tzNi2Euwt1h18PtmkmuZs0mdNK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda72797-07b3-4f8c-527f-08dab6a6ea06
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 16:35:23.5330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwwXVlzNDIevF975UjXpn68MqmFNe7KSL7LMgmh2Awu4boaT7rVitV+I9OLwYBuh6PF2V4JyVPPN98mBfNM0Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5383
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 24, 2022 at 09:52:45PM +0000, Luck, Tony wrote:
> > I missed the pre-pended length bit ... with that it all makes sense.
> 
> Though the other place where mce records are visible to user space
> is in trace records. See:
> 
>     include/trace/events/mce.h
> 
> (N.B. this needs an update to include the ppin and microcode fields).
> 
> If these new fields need to be in the trace log, and we want to make
> it easy to extend, then have to figure out how to handle this in a way
> that doesn't confuse applications (rasdaemon ... are there others)
> that consume the trace records.
>

Hi folks,

I think the "right way" to use tracepoints is to parse the data according to
the format provided by the tracepoint itself. You can see an example of
rasdaemon doing that here:
https://github.com/mchehab/rasdaemon/blob/c2255178a49f62c53009a456bc37dd5e37332f09/ras-mce-handler.c#L386

A tracepoint user should not assume a fixed struct layout, so adding and
rearranging fields shouldn't be a problem. I'm not sure about removing a
field. It seems to me that this should be okay in the interface, and it's up
to the application how it wants to handle a field that isn't found.

Also, rasdaemon does already support raw, variable-length data:
https://github.com/mchehab/rasdaemon/blob/master/ras-non-standard-handler.c

This could be an example used to update the MCE part.

I think the only (or popular?) userspace tool that relies on the layout of
struct mce is mcelog. This is not supported on modern AMD systems, and we
refer users to rasdaemon instead.

Another option could be to define a new tracepoint. Userspace already needs to
be updated to recognize new fields, so I don't think it's much of a stretch to
add a new tracepoint handler. This may be simpler than trying to fit
vendor-specific info into an existing tracepoint and then decoding it later in
userspace.

I do like the suggestion from Boris to have a length and vendor data in struct
mce. This should keep mcelog happy while letting us treat struct mce as a
semi-internal kernel structure. Also, this avoids having to mess around with
all the notifier chain definitions.

I'll start working on an implementation if that's okay with you all. I'll
include kernel and rasdaemon patches together so we can have context for
discussion.

Thanks,
Yazen
