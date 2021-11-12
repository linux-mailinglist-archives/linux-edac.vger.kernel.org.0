Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C67D44EE40
	for <lists+linux-edac@lfdr.de>; Fri, 12 Nov 2021 21:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbhKLVC2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 12 Nov 2021 16:02:28 -0500
Received: from mail-dm6nam11on2042.outbound.protection.outlook.com ([40.107.223.42]:39137
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235576AbhKLVC2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 12 Nov 2021 16:02:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiTEAKx+QFFPisZ4czIdU7NOPboFcEE4b1cZnvvwZ9qxiAz2ZG0UkEkeY1wo0b+DXOz5chYioyYq+xm930dgwB3pnRLtQu213uYpEsoeFPIiu1T9+222dv6zu9nWCqS02CabtUPrRofvfDGsiGTa3XGVp8r03dzveAYEp04gH+zY7B8VSlz6rfZUTHw1uscYHeRFuPa44/zzJe6yg/2TO51MIavvwrriBbE14OC/5ZxmlpJp3OmCvXdBncBumHO1agcGYUE6DBvT9RiR6WCs44DowV23XsCvnAm077GnICXgJ5+SKx68Ory4No+dXDHw5TXJlyDsxuG20RxCPksxSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADWyynxE+i6pUl86hl7qS9jBzD77FFn4rTyLSZDZ9Rw=;
 b=hGm5aR33K0GVJBG5rbC878eHVnVFf2w7T4GoMNCwRVh8W39cOc2KHhp+sf9Cg+Wl4IPbaygZHA0YI6ThGmVOb7L5DX4wSQqglb2USTM3Y+/XFuTBNSV9wCcLk7Aax9T7CtaABQofV/Lt8tM3FCImpTRdH9PHoBUcDHkIHFtiRJH/v63Xp5cGM37IGFWBwo1Z2fUN+lAOh1N39JQ27horcTHPfudtLvF+d1MiOBn2F2KD9NMVj0key2SbOxaP5LGioTSDdMQj3ix/uvvxuCVSPy5bxJ/Vu/4LBYPwhtPonHIa58IEVH5464V9aVh83gsQjDuWqBM1/3voXFtFO/1ylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADWyynxE+i6pUl86hl7qS9jBzD77FFn4rTyLSZDZ9Rw=;
 b=qzY47jc/Q1F6Zq8hp9dE532FMczc1hv90f+vLGGqqgydBokMdMIiaFVDLJPfgvip0FMGOnORNQoIxTBRc9ASNtFDgn8jo4pkfRvhvBtO9VUxqcnqxLRPblOvkcYlBd1qNf1QTBA5fWDKVRH+VuwgI2HIzUth4Nce8jr/GHqlG+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2947.namprd12.prod.outlook.com (2603:10b6:408:6c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Fri, 12 Nov
 2021 20:59:32 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a160:85b8:81da:73ff]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a160:85b8:81da:73ff%6]) with mapi id 15.20.4690.026; Fri, 12 Nov 2021
 20:59:30 +0000
Date:   Fri, 12 Nov 2021 20:59:21 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v6 3/5] EDAC/amd64: Extend family ops functions
Message-ID: <YY7VqRcZFhyqZw1B@yaz-ubuntu>
References: <20211028130106.15701-1-nchatrad@amd.com>
 <20211028130106.15701-4-nchatrad@amd.com>
 <YYwFUYDl8wvO02wL@zn.tnic>
 <0006a641-44e7-5cf0-04e2-8c4499765b77@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0006a641-44e7-5cf0-04e2-8c4499765b77@amd.com>
X-ClientProxiedBy: BL0PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:208:91::28) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.84.11) by BL0PR05CA0018.namprd05.prod.outlook.com (2603:10b6:208:91::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.15 via Frontend Transport; Fri, 12 Nov 2021 20:59:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53387196-42cb-4fe4-4fa0-08d9a61f521b
X-MS-TrafficTypeDiagnostic: BN8PR12MB2947:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2947B55A1FA26563C2AD2BD8F8959@BN8PR12MB2947.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HZRK2Z00e4gS/xD7jzA5XOwKFVujI4O5YwTuqaPjIxCLvGmKwSG8k//PpyYV7tMg6hyJQ048htPzqcS09D7n0+WEto3L+pFHXDfFuOIfJNc7J80ugNNdaPr/Xq7/F3gy7UI5rB+v6YVafisoGM84IpvjLnCuzG9u1YsjGLrEtPgJARykjnVY2Y79xkyJ+XIezFwbheTNJCOWIwGVGvpVbfPc6eQ9JmTTF2yG8HQ5dy7G591wD0l2RrGcj3SzNhxePTffMEYw708Ky73pVLj2wdYh5hMWKvQ5gtiC3PudGKT/4HHejuwglbS6h+RYVAEHMqDgPGp5ojUiilRpgvShbJj3aOficciaLd8O3d8owLXubUD5ql7phvxOsaXAI/l3v+F8ZeVyRNc3+REbKqdmNS8HNguPXb0BkBd8IwyC4lJrEMcYzdDkPmvCQcn4GXmGcf+4KvSiu0zD6+AtbW7oVpLG6oUiqqARmhIPD7WE3AusLSm5PF1hfNjjU8tl6YyZBME6kkoQyYscwf1DMiZV8iNEKVUZPTaiQeGiYllNU0Q/78NplEj16MW/eLYeTuhkf63bOdC3M+57ZznDKCc5y3sWLwK5zP98TvUljDDlyylP6v0n+NeelpHU3L8Mn3nzHy0XdmxSkwj2DZolPXHbdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6666004)(38100700002)(6862004)(33716001)(86362001)(956004)(316002)(4326008)(186003)(26005)(6636002)(5660300002)(6496006)(66556008)(83380400001)(508600001)(54906003)(66476007)(66946007)(9686003)(8676002)(55016002)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XOQl2wWXQFmhVT0TSCBuN+aOVAa23ckcRE1zMlT8dR7NoAnPxrF2+TDFI2n9?=
 =?us-ascii?Q?nujfl4/8H0QVSq39vDfLj3JB7PZMvaCRdqO6jPJRIrs1P8lHbJUxKsrRqQtF?=
 =?us-ascii?Q?luDKl4AqJy+b1JQ6JJfVxEY33RDz8AqlYNXftZIGYl07CXURD7YgyWpyebAj?=
 =?us-ascii?Q?d/ma5TTXGHsqsaZD5hp4RjB3sFw9LUfFYV2u+sr++dCQF7IRI4VcshdfWVDw?=
 =?us-ascii?Q?U7EYVCtW8gqO0j8/X3+DK0nXR9ZNqHIy5wbVhS3AtgcMxFsHZ+oCN6QA6WYg?=
 =?us-ascii?Q?ZTIwhXBNMEwz5kmxfF0iI22xhfTatUE2AgH1Ny7xjGL4toHY98h7VhzoTrDa?=
 =?us-ascii?Q?NNEP3dMUI2u+rrEl0vZM0KDUakQnLK9ai7vP+OWpqLdt6y2sEXDYgsTVL4Yy?=
 =?us-ascii?Q?83u3lazQF1BIDLgMNcaouML0tUIs77ULuqVGXfWt4kfdzUSlgKe/8uqGvPeU?=
 =?us-ascii?Q?ZASvCPkSPeoGmExwh5BsfCYzeGfwWyv79rsKCYXmywx3KuXECXdl5d1NbhWK?=
 =?us-ascii?Q?SluhPWw2fr0++/jBCdo/FZmWdiA4u2pilEEPDQB0UAwDXwHfMCZTlcakEojx?=
 =?us-ascii?Q?mkbWjWPJg+5CfcFCebrL7++Vsr6APBoeu1fD4tDzcWqjp57PyuhSkP1xU1fc?=
 =?us-ascii?Q?ZCzlsLWrjFwEVl7V2lzFNfVMw76kbu8iWs6YQAcqQdEGP1yztVewuJXNS0fI?=
 =?us-ascii?Q?/PFEfY7erJUUJMZFK62ozALqSBXbObWzGsQ79jMa6nzM2PoJu4ig9q/FnP9T?=
 =?us-ascii?Q?MQ78xYq6XDiqIzKuUVn52OsHx9k8IIwN7pHPI+NB+nNVST2nkuVVL3rp2++D?=
 =?us-ascii?Q?JW7cZkQiVaLkMnDZFIsJdqq4+tiucxOjZLImhNEXgZbUKvij+iJIcMzDTN3B?=
 =?us-ascii?Q?T0Q525w0kkNu0Bs/h3MZOSaftU7o9iur4U41f2Z4F5SSMeMbZBuQ3sFanBRb?=
 =?us-ascii?Q?X2KXUIPmJ6y+4C98ConOQ3XW2B+j+tKjuG7YiSoVen9qiCBsRcNAAGezufKp?=
 =?us-ascii?Q?pVyWyXcQ1e/DmBnDHT9npoLlDGxke4Y+PSRvI+EdOfi+uD5xAJPKggTwA22o?=
 =?us-ascii?Q?9D9vtta+YEb0y6geAYyQEUxmkU2xUakhqMmQaHNmnk26Wc6x018hdf6us3Nc?=
 =?us-ascii?Q?jpzmvWSgY17wAf4xaeIW29+R0ubb26Ew+KAORYKgN+W08Eyqre3ZqcnEu+ge?=
 =?us-ascii?Q?KXvDCSHUfYKKf+WbsAKPjuFgmDy7wymjg8f8+39vd//pY6GBrgHZWepMG6dX?=
 =?us-ascii?Q?QSoWN4s0UBAtQvm9Sjz1iQD+WUeKviFiRK/st6JTewRXdV1E7ORSr93KLesE?=
 =?us-ascii?Q?mTxYzek1V647psbeP2MDbXJeia3h4o8S3JT1wOqiropSb0r250eWzWcRLrXG?=
 =?us-ascii?Q?xFjOF2T+aDjLx91yr/ZoALcB9kE9cwxUupjZYVWuQPzxsFjooRupimhUrb7T?=
 =?us-ascii?Q?Rw8B+J7fUhH3p+N77cOHLnv8MdBtLDdbVKYGgjXe7fl34fOrbhrbeI2yFWFA?=
 =?us-ascii?Q?GWVDhAjLY/uwijmb2Sv8w4KiKPBrKfNe57s7aLOVfpLRpZtWhV7ZUqGMSoQy?=
 =?us-ascii?Q?6a7/dYmVuOuBPhtxQyGt9sXL0aMNoj6BhfK+jxPyMnU+YV39YsUPp9fTkbyt?=
 =?us-ascii?Q?YrDoHhhCz9gjDMrRLXiexWk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53387196-42cb-4fe4-4fa0-08d9a61f521b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 20:59:30.3862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l73lHBMO6mPktwXhjPegVPKSVgvGJDZb5cH81Oo1uaKE2PYnD271uiMbo7obqstQKwpV/ICXVu9avWP6aVpMIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2947
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 11, 2021 at 09:53:32PM +0530, Chatradhi, Naveen Krishna wrote:

...
> > >   struct low_ops {
> > > -     int (*early_channel_count)      (struct amd64_pvt *pvt);
> > > +     int  (*early_channel_count)     (struct amd64_pvt *pvt);
> > >        void (*map_sysaddr_to_csrow)    (struct mem_ctl_info *mci, u64 sys_addr,
> > >                                         struct err_info *);
> > > -     int (*dbam_to_cs)               (struct amd64_pvt *pvt, u8 dct,
> > > +     int  (*dbam_to_cs)              (struct amd64_pvt *pvt, u8 dct,
> > >                                         unsigned cs_mode, int cs_mask_nr);
> > > +     void (*prep_chip_select)        (struct amd64_pvt *pvt);
> > That name should be "prep_chip_selects" - plural.
> Got it.
> > 
> > > +     void (*get_base_mask)           (struct amd64_pvt *pvt);
> > > +     void (*get_misc_regs)           (struct amd64_pvt *pvt);
> > > +     void (*get_mc_regs)             (struct amd64_pvt *pvt);
> > > +     int  (*populate_csrows)         (struct mem_ctl_info *mci);
> > > +     void (*get_umc_err_info)        (struct mce *m, struct err_info *err);
> > WARNING: Unnecessary space before function pointer arguments
> > #652: FILE: drivers/edac/amd64_edac.h:470:
> > +       int  (*early_channel_count)     (struct amd64_pvt *pvt);
> > 
> > WARNING: Unnecessary space before function pointer arguments
> > #656: FILE: drivers/edac/amd64_edac.h:473:
> > +       int  (*dbam_to_cs)              (struct amd64_pvt *pvt, u8 dct,
> > 
> > WARNING: Unnecessary space before function pointer arguments
> > #658: FILE: drivers/edac/amd64_edac.h:475:
> > +       void (*prep_chip_select)        (struct amd64_pvt *pvt);
> > 
> > WARNING: Unnecessary space before function pointer arguments
> > #659: FILE: drivers/edac/amd64_edac.h:476:
> > +       void (*get_base_mask)           (struct amd64_pvt *pvt);
> > 
> > WARNING: Unnecessary space before function pointer arguments
> > #660: FILE: drivers/edac/amd64_edac.h:477:
> > +       void (*get_misc_regs)           (struct amd64_pvt *pvt);
> > 
> > WARNING: Unnecessary space before function pointer arguments
> > #661: FILE: drivers/edac/amd64_edac.h:478:
> > +       void (*get_mc_regs)             (struct amd64_pvt *pvt);
> > 
> > WARNING: Unnecessary space before function pointer arguments
> > #662: FILE: drivers/edac/amd64_edac.h:479:
> > +       int  (*populate_csrows)         (struct mem_ctl_info *mci);
> > 
> > WARNING: Unnecessary space before function pointer arguments
> > #663: FILE: drivers/edac/amd64_edac.h:480:
> > +       void (*get_umc_err_info)        (struct mce *m, struct err_info *err);
> > 
> > total: 0 errors, 8 warnings, 507 lines checked
> > 
> > 
> > Please integrate scripts/checkpatch.pl into your patch creation
> > workflow. Some of the warnings/errors *actually* make sense.
> I have noticed these warnings. As there were previous definitions, i
> continued with similar indentation. Will address all of them.
> > 

I've seen the same warning in some of my patches, but I've ignored it for
readability. I'll need to make changes there too. :/

Thanks,
Yazen


