Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1086157AB
	for <lists+linux-edac@lfdr.de>; Wed,  2 Nov 2022 03:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiKBCg0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Nov 2022 22:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiKBCgY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 1 Nov 2022 22:36:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7665EE0D5;
        Tue,  1 Nov 2022 19:36:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlijI1ARD0Ir/mjyK3ylvub9kMLDic89uRJhK5T0vA5h7V7XKd5uSH/tLNKz1SxcPOzT7YwVT7/5WLpF5eCzJFvkqx0dxI80PiUUPEWkKBR7QpcVx9IXogRYQ2nVRbnGgDwKS8zdk2oBEyLLNpeEO44qg/SIv6vIilvN2GBBLvnTfjSnWdPJJ8EGbodtedVPPrAkKTnicf5vNNCsjtTo4/Rl3kJbHdmSX6FpNZI7uf8a1AV21vr8vEtDI8ECtt2CDfmsRG0MoVuhGEM/dOZ+d8KPlEryqiPZaIy3cSYCupRw7gCJHc2vTaLBs8dNPL7CIja5R5QxZTp3yqGByvh9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3x/zXm31tYCpfMt9tAbbPJsWvGOHse6g0TQiniJL/NQ=;
 b=apZQWkcmpR5Fk/OYo7Y1dujodKAdsq0vJVS7QcU2kFJkghpgo3U1UV2+GuUbB04DYUmKF380YC1cJmK95xvCqotdTp+e2ehN7SWm0jEd9nbuV1aeyX0Dpbu2ZsJOhKvX6ozfkUlNKO/OyvPnhgAlpVE6B6g3n0hB1e6PxndN3Ig7CJKpzm+3CiCp+NXe4rvkaszli3RoLUUVQR0Ws/ubiYbjbNWJ6fUq3u/mI+8KhhPsIcq+UuWKpbAE24zorLGOtB8p9vP9OWvINIyZDkEcWpaO6yCMZamkHWxgTBUw1iscriyfSQvjoSWvQKEyPyeobJuMaFFuSUs2TqmA+Z1kCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3x/zXm31tYCpfMt9tAbbPJsWvGOHse6g0TQiniJL/NQ=;
 b=4s7SYnnTiRK5lqsU9Sugqe6Oo4bI1P5FtotLvjrZXlHAcR3V0S8lq2xmi6d5zvXFZyBmvZ7YnCxCh3Jp8pLauDTwVz7MCBWpdekdHOLChr1WMsYq9AGNf84+wLUinVyEUpn5aw6lrJ0XLFgjKXZRWy3SMsUXyYnUXwnvcvheiY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CY8PR12MB7098.namprd12.prod.outlook.com (2603:10b6:930:62::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Wed, 2 Nov
 2022 02:36:19 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ee94:4f22:751d:278a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ee94:4f22:751d:278a%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 02:36:19 +0000
Date:   Wed, 2 Nov 2022 02:36:16 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, mpatocka@redhat.com
Subject: Re: [PATCH] x86/MCE/AMD: Decrement threshold_bank refcount when
 removing threshold blocks
Message-ID: <Y2HXoHeFt+BJRb6n@yaz-fattaah>
References: <20220614174346.3648305-1-yazen.ghannam@amd.com>
 <Yql9TqFtebd2h9Z9@kroah.com>
 <Yqnj88FPkZ6kBU7k@yaz-fattaah>
 <Y1kJCHBtatohj/JK@zn.tnic>
 <Y1kiNBh3/XBNe6uv@kroah.com>
 <Y1lUo08UzaqIaI7r@yaz-fattaah>
 <Y1l8nx1KnTFP1xKj@zn.tnic>
 <Y1mOEfEM6MdnV8CX@yaz-fattaah>
 <Y1mUn/xvx1RYPqAQ@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1mUn/xvx1RYPqAQ@zn.tnic>
X-ClientProxiedBy: CH2PR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:610:57::37) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CY8PR12MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df55ded-e945-485f-4187-08dabc7b05c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wBDkagMuWbLnKEop4k+VkYfSAdCzOvN66Pr0HoMWcEtS0V7s0ohYLqo/fcdDq5X/KnHiEAAPJguf4KCPjTt3VKq/ohLkHlCzH81IJIQk+N+EZKnDimJy93akhjQNpbYvQXbyuLt/AlhBHlhYz+2mWkWAnoEC9N5XLo8lT0KIDMwgM384QEQeTD4TeDcJ2huCHgBCQdkYKiW1nlIuW0qKKy1mdsxqtGHx4aFULncdxQZX0Lgc+R8RClj4LhV9evID0kAhirkynTYVM6aWXjNUTwOd/RkBT7TXFlLqz8NY9YO0lsqPGnZVrraqOg3fjZhB28uWJEXXbQhpVSiDVUiYJNRKIXpPdHe0atY1ieX+EAXHuckdS6uqtmOu7e6kKuFF7sl1DWEXTFQbPp4uPi5nHn5tJBbc6GBMuo+tmiA1SFpUE7tCTvWzkrfcAw7E8tyrzacbbL+Dd0hf82J5UJed/HZI5RsagaVlA1PcOPWxb4b6QcLossut0nliO3JGjMO5dYuLu4KTruhJm6TQXa+ih8Zuxn0hglXCkyRpkg9T6ZK7xcOmpievypu+s/AC/+ZBhlI3YdTge1ZQ1BwoAj4b4ufvQVcXm/h6FDsJZtUVvD6+NtNPoI2d0Bn1T6sQKL2NKS9qkx/MfEvvFiliWRD+vtlegkPLk4jOWyQG9iRreTL1gXlHPgHXlFWTbKn5bbABWhQ2h/qshNMdDs9ohHnXAtxmMBYivNoCXdLyifBci7F8ICh+9g9jLFQoPTYc3ZjF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(83380400001)(9686003)(2906002)(86362001)(38100700002)(5660300002)(44832011)(41300700001)(66476007)(4326008)(8936002)(66556008)(33716001)(66946007)(6666004)(8676002)(478600001)(6506007)(316002)(26005)(186003)(6512007)(6916009)(6486002)(66899015)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P4tHvgPf7imcy8dF15Hg2aNuT8f4Zn23DO988oa5fWLm8EIYXZopwR9b/Fla?=
 =?us-ascii?Q?fTtmC3ujJb4cqvlf/cuPDpHG4i//DKJPtfDrahu9/SN+NZMJxXhZ8q3PvUL6?=
 =?us-ascii?Q?t1CAL7RfI/z1YrfZc9/gQgFZWY0ZF3elaN4yMtWB2do7o9qyEPvPGEh/MeIW?=
 =?us-ascii?Q?N15Ji10nfA9wKv9hvH30eSx4oFzK4AsVV4o9RhqFXUb1TLZ6v8SxYtKXkyfc?=
 =?us-ascii?Q?ETx1OtG/kJvD+rxB0ZB7B6IAhKkWgwHIVZmQj+0lZi3rI1CJiIM0QyhK8wvn?=
 =?us-ascii?Q?SlNya1oE1R0xHzMm23iBstOYRwNiQo1GQJGOJ7neX0U9GlH3uDoBHcHVq9lT?=
 =?us-ascii?Q?myNVgb2Vd6mTO+Ts8gaH+yGDvze7oNBasU4XFCLlZ8kpmajwUfN76Qqj+NcH?=
 =?us-ascii?Q?E/r9z+IYFZ1u2JAzMCqc5ILDx8O4qijDRdWY3epBbdiCMRlmNKEagEgXLkp6?=
 =?us-ascii?Q?mu84F6WwoWAM6XFFeZeDKnnJkEXV53/XHbavaMocCYaGki/bpiWlEAD7/2jE?=
 =?us-ascii?Q?LVrmj8qPQuqZfenTTIKecEH05F0uum5TaV8fDjIzKTRLblxRbPPBR4R39M3v?=
 =?us-ascii?Q?ocwaKpm5AyeH0Ox7iwKCA9ayO6hR8Q5i3HSgsJXreZeNKDAS1hmD9/mRdmme?=
 =?us-ascii?Q?EwD0RQB6YX8fZ/A1UmEp6ZxzM6XEtGsG86YGVJdojl16aALkOE8WvhEvowQX?=
 =?us-ascii?Q?Jmmdqj3hPiHUFO+/Rn+1gt3Z2xJ8pWBEnS4Aw3+YQjsUBbiGuja07EW/gC3Y?=
 =?us-ascii?Q?SE1lVwcjJzcXcHEg4KbhxfaVb0Jkf+Jgv/PxnK1QmAd3eerAst0HJ4B1x/aI?=
 =?us-ascii?Q?kLNu5WImmd7MNOSEACjRU8Ez4c8b0thaXvv9AseqxRxCEityBL50vWz8Twom?=
 =?us-ascii?Q?4dE2Vz4EL1zHAyV/UxQt9kRK08wpRc1o/KprUHMeTpwyzeTt1kqT2eK/1Ywf?=
 =?us-ascii?Q?AQT8AC8c/UTTnrmEPCZsjovSfZ9nZsMOq2+f6mouk9AVNxKaSsqYZ2hfvAiA?=
 =?us-ascii?Q?2H2CexNdjwiIcKLIGc8CFbF5ENXzS9ZEqrQiL4KTtJXKPzr+YPsQvLHzqKZo?=
 =?us-ascii?Q?H/CYdYWQrgGLPxnz7lLwYWJnoNpKEYuj9/pan3z8zGvB1dEQ7c/3Qcm77fE5?=
 =?us-ascii?Q?+PpTucDnMlPFeubeIaq0Rcm07plfE68yBqU3XwBSpBiFQUDhl5uiH7us+UF3?=
 =?us-ascii?Q?6szN9RH2PswXjqbEilxoQqKnbS3pgSr/3ERD4ia+6JhNZ20REvhHezOEAXlD?=
 =?us-ascii?Q?sT21lValw3iy0uQllxXvzF34cWGyx7IsotjLAYZISk+RtLrxgzWacXCP9Uqj?=
 =?us-ascii?Q?AGvPBdyyVkOQ4kjt19I1yJx9RcBdgrDRCAnjX/IRPuUoWKA1wQj1syt9CN23?=
 =?us-ascii?Q?XfHGZVSdJieS/hKw4eJdGc+1UO4zCw9vlReMcipuKXQ/AE4X6GbWl3DS8R1r?=
 =?us-ascii?Q?MghLQWsm9sPN4Sio6ER4lmKKAihg7LSHl5OrA+ECCSmTRlRzhxKRHSjbTAl3?=
 =?us-ascii?Q?NABSVrCMWpWcpzL/Ca5sRb0ZzgDRp6MO/VjftTcc8SU/tJrA68//tH4MUtLU?=
 =?us-ascii?Q?IZYW6CwPVe2eYvOcwa7IOk477VsS4Hnt9/Gg7Nd8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df55ded-e945-485f-4187-08dabc7b05c3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 02:36:19.2840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2uXrMT3wLlJd7g2oKmE4gjzQ/2nzPKIBIHn4vKCGiXBIqQw+UXZ8WDmh/nORqhVFzHNRBHBoLmw7TLMEnmrHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 26, 2022 at 10:12:15PM +0200, Borislav Petkov wrote:
> On Wed, Oct 26, 2022 at 07:44:17PM +0000, Yazen Ghannam wrote:
> > 1) Apply the patch I submitted as a simple fix/workaround for the presented
> > symptom. I tried to keep it small and well described to be a stable backport.
> > Obviously I wrote it without knowing the shared kobject behavior isn't ideal.
> 
> We'll see.
> 
> > 2) Address the shared kobject thing.
> >    Here are some options:
> >    a. Only set up the thresholding kobject on a single CPU per "AMD Node".
> >    Technically MCA Bank 4 is "shared" on legacy systems. But AFAICT from
> >    looking at old BKDG docs, in practice only the "Node Base Core" can access
> >    the registers. This behavior is controlled by a bit in NB which BIOS is
> >    supposed to set. Maybe some BIOSes don't do this, but I think that's a
> >    "broken BIOS on legacy system" issue if so.
> 
> I guess we can do that. And I even think we have some code which finds
> out which the NBC is...
> 
> /me greps a bit:
> 
> ah, there it is: get_nbc_for_node() in arch/x86/kernel/cpu/mce/inject.c.
> 
> 
> >    b. Disable the MCA Thresholding interface for Families before 0x17.
> 
> Can't. It is user-visible and you don't know for sure whether someone is
> using it or not.
> 
> Believe me, I have been wanting to disable this thing forever. I've
> never heard of anyone using it and all the energy we put in it was for
> nothing. :-\
> 
> We could try to deprecate it, though, make it default=n in Kconfig and
> see who complains. And after a couple of releases, kill it.
> 
> >    This is an undocumented interface, 
> 
> Of course it is documented - it is in the old BKDGs.
> 
> > and I don't know if anyone is using it on older systems.
> 
> Yap.
> 
> > The issue we're discussing here started because of a splat during
> > suspend/resume/CPU hotplug. In disable_err_thresholding(), we disable
> > MCA Thresholding for bank 4 on Family 15h, so there's some precedent.
> > c. Do nothing at the moment. I *really* want to clean up the MCA
> > Thresholding interface, and the shared kobject thing may get resolved
> > in that.
> 
> Clean it up how exactly?
> 
> Put it behind a Kconfig item, disable it and remove it after a while?
> 
> :-)
> 
> If so, I wouldn't mind. No one's using this. At least I haven't heard of
> a single bug report or of a use case. Only when CPU hotplug explodes and
> that thing is involved, only then.
> 
> Might as well remove it. And then remove it in the hardware too. RAS
> folks would love to get rid of some of that crap which takes up verif
> resources for no good reason.
> 
> :-)
>

Cool beans. I think this'll be a long process, so let me start by removing the
shared bank stuff. Thanks!

-Yazen
