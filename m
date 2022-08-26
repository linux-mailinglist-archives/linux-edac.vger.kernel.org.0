Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AA05A2DDF
	for <lists+linux-edac@lfdr.de>; Fri, 26 Aug 2022 19:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245401AbiHZRyl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Aug 2022 13:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbiHZRyk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 Aug 2022 13:54:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672E1E2C7D;
        Fri, 26 Aug 2022 10:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661536479; x=1693072479;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lfaBScKvLAftfvCgKSUHZAfprcnVH0MyPOVDFw6d0xI=;
  b=Ct71P5nthRMW4zE6dbPbfVCBOgSbdOf4HE0rBDF6vjTu0KzNIGnYSgG3
   qbZtF2AyT4tuGDwUtSq26GvuENcNlwBMLETqclLnTfWEpAtFqPcLwEssE
   I6dl4aiiRHgtf8N3r5r0yYmb7a2b9wZ1Q6ZiflCQlzToAkZKOLRcmm7JO
   bGCa/gXnJ80obP6UQD/7ProvoeqpR7Z0gSpBwXmAM7kODYKUQk/Wwi5cf
   Lb/TbvE+VU4+tWXr7vMZo63V74QCcgpph7dnVeo9YmtSnm5W+Tk3PN4YE
   zndNaY3XrzDqkSq99pOYernAr1qAH5MwRWiAtIWJeHM99zgtQ110pEq4W
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="277579110"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="277579110"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:54:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="736703033"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 26 Aug 2022 10:54:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 26 Aug 2022 10:54:38 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 26 Aug 2022 10:54:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 26 Aug 2022 10:54:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 26 Aug 2022 10:54:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBAWIxmAJ1CtrzVuct4U6E5Hsd2czYdiJ8JX8AhUhOpkASbvK8X2NIjMDLOfVEaEHvZjYybX9vv3J9ft1OQlkAHHXgiNdR3y1vnX1k3z1fpl9wXXhVh42hwh/hQelg4rbSFchndqFLnrjLEUB5G28QcHHRSvLFFJeUb/VPZPIXCG1k83YcocWPD8/zPbprnTKbHwnc3tw531ToO932VkdqcwiSGwnjopaMKTs9JhkmKsFC4r7fvxZ1zgKtFWOGuQ+NoguLTybt54HAGPYbuGkdBd/lVHHV6cTTEL70pZeJTOI8cSihRazKRdtlBmLyqXcBKenUo2AoJpI2yCetCU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vlVjj0/pECAjxm1BjR/58sGM463LYu04BtEsyGM1XA=;
 b=md4bjyGFk3ULv0OoEBC/wTY3Np2LXcC7tJgWZqegp8l3DUWvmbAx1KEd8SxKf5P2ysP6NmZNmYLApIPFfapE/qRZXbEQ5/tMQ+Sg9dv1nfZP6Z1651zq3xbC7nQ9uqRjLVs8Q4H/9BEbfTbf2wHnvOc8LoBxWoIOjiyd/awP0K+RfHqCqZEz5zAuoNFs4Q6uO8Bnuc9By5AnFnn/XR8dpOiGrzkjrwexC1Ptjw02go5r4E1WnWGqKNaLCVtuvqbIFF8rSPeQw0lBrpql8X042Qwis0PeUEPuROAx7Nk18PXiYKwvUSCN4AGswMMOcPObOuOOE/HAcBUeyAXWF0sj7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4092.namprd11.prod.outlook.com
 (2603:10b6:5:192::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 17:54:35 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5546.024; Fri, 26 Aug 2022
 17:54:35 +0000
Date:   Fri, 26 Aug 2022 10:54:31 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Borislav Petkov <bp@alien8.de>, Jane Chu <jane.chu@oracle.com>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v7] x86/mce: retrieve poison range from hardware
Message-ID: <630908d7e6937_259e5b29445@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220802195053.3882368-1-jane.chu@oracle.com>
 <YwUFlo3+my6bJHWj@zn.tnic>
 <b3880db6-6731-1d1b-144f-1080a033ad01@oracle.com>
 <Ywf9ZL6zjzSf5pdF@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Ywf9ZL6zjzSf5pdF@zn.tnic>
X-ClientProxiedBy: BYAPR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::33) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70499d97-acc2-4d55-b18f-08da878c0930
X-MS-TrafficTypeDiagnostic: DM6PR11MB4092:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRVSrri8QmO9Ja0OBCCQMgru1r6wMLsCee76wnDVsiGEe6r1RZXvYq53NTAdZs9oEBCDIHuIknJS2Bz0uMu5Rng2rS1OuaWpcg2wLHUS0kYGiKlxQZgmoCBW0xCFhxJY9ag7PBc39a6nS/jT6jiD2oXsa0v+y5PC6KX734V2je9InfCaFK8rArxaM1YYMiiJAxQEgWapblc3F0F4i2QSLyMhBminCv0ZYbtXqSUdFkdD8psKKeVIU/v3ebHJcOyklcjg+stZiDC4jvtzp3sP6g1mmG7EU/u+HoAtSlKx7y+UcxeFZ0aCIxP8Mk45yx+hlziwRVxIR9cQRIRwcmbRZDhgNCKZwYARH0HERARiHqtx+yDBqG7vwir+C7QDONPDbyfD/HVExsXb0Yxzrj+0dotPmy4bM0+kzN4qq7tE+94EvgCVCYQ4PEjioXmcbKnBFAmFr0VxXh1tRl7SdL5CxAEdSkiq+ShGO85v5mK9jZA6iCmEqft+kyx0Gbp4q4+DsLGtrPJF3owN5Q1vj6uyxtFSh9+T38wgxozg26AQ5qTIgSb27B+g5MxllGLgUoCq22ypgs8G+eVMq0RBbDySBefMPOeUbS10FPshF+0q0ptMJ2aP0Qv8irR6OJGe14I8HZKiy8MKZtwhX04ac2K2ftZ4f9SGA8I5mQ5e3QJOMT+JuxakBd4O8Sv2Gmls47wD+DqimZT6bSzirLW+WRpFwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(136003)(346002)(396003)(110136005)(83380400001)(478600001)(186003)(6486002)(5660300002)(4326008)(316002)(54906003)(66946007)(66556008)(66476007)(8676002)(2906002)(82960400001)(8936002)(7416002)(41300700001)(26005)(6506007)(6666004)(6512007)(9686003)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xfeBra9bIx5qep4CJI/TN5+2p4405IUb2XQ16eXAYmhslHlZ044Aj9wF5CEy?=
 =?us-ascii?Q?eqWdf6oBxlCwxwyhd/8qEesd9xmU+DY5l3kU1SZuWKqXGKO+p+I2cSqPbAfK?=
 =?us-ascii?Q?EHQCRW/8YsfkU8j5CzBFE3S9A9z1ofoZs4g3wcruDi84YZobfbTFHXOvbOkX?=
 =?us-ascii?Q?marydcGnV8SUVd+CsYyApHJESfF2/ehVq1SWM139WLHoC0J+Hbuv8Sd9vAwu?=
 =?us-ascii?Q?FOUqjBiWwGTxVh/KVVGREQK5d2apr4xO0h0ruljwkkI+BOKx/f2WEoKUJUf4?=
 =?us-ascii?Q?9pIRXnRIfHjopwJTJAG0r8aU9zSkQayTxd3rpQNMYobbK74b9iS3Y0XRVaQf?=
 =?us-ascii?Q?AlIswW86o2i0pPDeMHAjgPPpJbivKvaLdnJeYaCIHEw9JTQGNcgM8aTlGC7L?=
 =?us-ascii?Q?rjZehH5YTbK6z/YxoMu9xPEzXIhpevDisLVqHnB0TaVZSvbg3pU+0yRESmdr?=
 =?us-ascii?Q?HGX5BLo9TWGZgZ4O9lGnpWmUgGWK7Nr3PfG8MhH0J5zZ9jqdR/qikbNUhTar?=
 =?us-ascii?Q?imvd6BoE6muBy55tFlWPIha2l28ZV13GlcWYNuMsT7vMZDoHHk8dUMmWoiCI?=
 =?us-ascii?Q?qWy+IrMYXjokW3xWK+t+SGtlNIEBAXGSCpDQPYeVFlAPybuLrr0qAtL4829a?=
 =?us-ascii?Q?qU3lWJhZybllyK5vnToo6pOD6T4JGKnz05HEu8sb62nmvl1clB3GMVE1jPla?=
 =?us-ascii?Q?CpH0hV1TRhN2TwN3/ubd8lDUaJX7KtylRZX3vhYrE0Rm3F7IbUK6HYZ9EMRb?=
 =?us-ascii?Q?PDb2jMimFsk7yH7RiWyeWHmom/4zrmjVU8HWhLCUQC56J+zqpbKtis9ftt23?=
 =?us-ascii?Q?4ZH7FMXcjBjv6akoq6POeOTJARwcHAoaFerBf4L5GYGXQHQpIRmcBNM6VAzs?=
 =?us-ascii?Q?K2K2klBNsNCqXg5mxiJjLalENPdpNDDm5reZmZf6cG/T+BZv9NIEnj6rWBEh?=
 =?us-ascii?Q?ftNdYW028sB1fNQc5rggjYnlenTWFesVKFEvzXepVlkM/DLuBbOqG8KUayWY?=
 =?us-ascii?Q?Y39s3NI0UqwaM3pqtAlaxUbjCuf0n0B6ls+Coj+bJUnsGdO62nNKLIKQRsx6?=
 =?us-ascii?Q?CpJgbPm05VsSdIt5opM1Ktutb0f131N2Kloro8HWxI58flpFzihnWt3jk5yv?=
 =?us-ascii?Q?9jsU07TpctNlZEsfAxoplJXAZPF1+QJ8ZSK91CrbK4DI+Wylho1wdMwvs3dX?=
 =?us-ascii?Q?961YmfNAIJa0a0lCf9F+KH0zF9IBG4V1DUGJctan+PZNGbiOZQMs0Y+bToS0?=
 =?us-ascii?Q?GXAvIhaHDf4gaAbw0qhw+08TP6GSHHTGC2/x88PLzuM+KgimmlreOo2J89wn?=
 =?us-ascii?Q?fRDH19OgLU/GcLQm3H8adf9efAu5z3k3xuyLszTpfzlm+DSHA02DH6+cBegC?=
 =?us-ascii?Q?NX+QLX46skKAKZuEPr/AOkaFzp1P0ebyVJAsp3uYtVWal/3FAneGLB7TP18E?=
 =?us-ascii?Q?8AvoXg3lJ305XojXvczzWvG4mIO+sWCcYuvI5nyLgGSxlTmnHqwawgXWet35?=
 =?us-ascii?Q?mSGBrVO/kpumsQhIXdxKkwknNd4Z6QiJmepQfeTHmpAskvw688ahNGNCOliN?=
 =?us-ascii?Q?PItc0EJ/0V6LNU8v+/yyyJRye9BhD0AkuTtzzYj8CCZvaAkRS0ELNPjYxCAC?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70499d97-acc2-4d55-b18f-08da878c0930
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 17:54:34.7891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FE2hcl+PULW4zzYXN9RhYHjr5Nh+lBpd122J+F5EGPJQyW2JgnF3hRGfjHZqZ8LL5jYbr1pQyr77cZ5hUAUC315qPy3kXHs6f2wPg/v1/ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4092
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Borislav Petkov wrote:
> On Thu, Aug 25, 2022 at 04:29:47PM +0000, Jane Chu wrote:
> > Tony has replied.
> 
> Do you really think that I can't look up what field means?
> 
> What I said was
> 
> "What I'm missing from this text here is... "
> 
> IOW, what I'm trying to say is, you should formulate your commit message
> better, more human-friendly. Right now it reads like for insiders only.
> But that's not its purpose.
> 
> Do you catch my drift?

How about:

---

When memory poison consumption machine checks fire,
mce-notifier-handlers like nfit_handle_mce() record the impacted
physical address range. The error information includes data about blast
radius, i.e. how many cachelines did the hardware determine are
impacted. A recent change, commit 7917f9cdb503 ("acpi/nfit: rely on
mce->misc to determine poison granularity"), updated nfit_handle_mce()
to stop hard coding the blast radius value of 1 cacheline, and instead
rely on the blast radius reported in 'struct mce' which can be up to 4K
(64 cachelines).

It turns out that apei_mce_report_mem_error() had a similar problem in
that it hard coded a blast radius of 4K rather than checking the blast
radius in the error information. Fix apei_mce_report_mem_error() to
convey the proper poison granularity.

---
