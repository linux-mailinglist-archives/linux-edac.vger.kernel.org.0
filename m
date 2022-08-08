Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0CF58D07C
	for <lists+linux-edac@lfdr.de>; Tue,  9 Aug 2022 01:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244549AbiHHXab (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Aug 2022 19:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiHHXaa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Aug 2022 19:30:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A5326D3;
        Mon,  8 Aug 2022 16:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660001429; x=1691537429;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Scu1tEBQYKmXare2D12erCNo+MBhRcvsorowMPBYTtg=;
  b=L2IgUOgt2O1Z+0fxeHX3LqZA/XH8c7WNdORwrd2xQ9Ukwfaz6if3Db1L
   sIwYv0zMfErmYsUkjhkR+TdmIYevQuapiBLEFL9UTPh6l0MFscjxIr5/w
   BSHS5Y882h6IOjOwws+ZxDhfJnek/w9GCjMhwEWpYkRM4683P02nVTcI8
   w0Ui95KrA0eajVxrpSTf+bb5smvcGxg3O9jCKzb8lQYDptQnXO7f5apmE
   RV1ljCOoKlV+T1dT03hZjDcbHtCAkts5B/O+1PGV5r7hHQl1SLEt7wbUq
   855gEu1LLszjv+Pchh0KckFu59raqu3mttjuieTbHOIB54laazdKapDUH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="316638313"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="316638313"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 16:30:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="932263619"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2022 16:30:28 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 8 Aug 2022 16:30:28 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 8 Aug 2022 16:30:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 8 Aug 2022 16:30:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 8 Aug 2022 16:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrkGInJiZC6uWahw8hdVRf7aB75CzrK8e5B0MJWwImi9/n3Gl6js+OhZkUgucR23h7Z3duDWhkND5f6lGU54t2ejD5P+VSW7ySdWJrBL79796DvnfimxyT0FQrrdmpwfRgoEXXfFmqDJfYLQ0ev+jTjfXF6DJZ3UDjAJSHdTkZqHQ6RXrWJ6siYy2AgcS+NESu5Zy7iBcZoF/inbUXgqxHhYQMzr6H+7/LWr+6meoJJs83wPvJLC9nWoJiT09eqZaAkeAeTc6sV93IoXQG3+A+7jf/nYbKA1C1ATlI5sD6BMLTDt6XnzXSqNHNsjUy697fK6OXuL+AAlKIyEZFURDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuZAKxLrYa/k7Hz/3fcM+WLA7aHG+T9hpPrnATw7lFQ=;
 b=IptN4+8NTJGJdWwbi6Iecfbeh5skoW0KrwTZpTmC3H42tivpTjFK47Wzct+TlOZ+n8xo/qKLaOCTFZ0nfXgSTP5Hzhqg24pgvxi9DqWKxt2AUM18j+ek1T3O+HUU6omUxFJNVTGZcHAGUOf5iXKxlSDOcQFSnMtpbrG+4NviYeRFRKqhFYtA1wg1/2EYZWNBWO8dcVJyq3w7Ocsvyrb66wmKI9IZTyc24wguoQAZfxB4V9Z5Nl8JkOoPSCkEeLE+PxI5rzNmuKXW9FhXK/4Q5JVoH7YHRIh5ZdRUO9yhbSMyADfjMBbq30g8qAPriMVdL9Tj0pvnVXnKi9X2XhIhDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW3PR11MB4572.namprd11.prod.outlook.com
 (2603:10b6:303:5e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Mon, 8 Aug
 2022 23:30:25 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 23:30:25 +0000
Date:   Mon, 8 Aug 2022 16:30:22 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jane Chu <jane.chu@oracle.com>, Ingo Molnar <mingo@kernel.org>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
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
Message-ID: <62f19c8e795d1_1b3c29448@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220802195053.3882368-1-jane.chu@oracle.com>
 <Yuo3dioqb9mDAOcT@gmail.com>
 <833288b3-4838-63b8-b22b-f22538877957@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <833288b3-4838-63b8-b22b-f22538877957@oracle.com>
X-ClientProxiedBy: BYAPR08CA0031.namprd08.prod.outlook.com
 (2603:10b6:a03:100::44) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 510444e2-7504-473f-7f03-08da7995f88c
X-MS-TrafficTypeDiagnostic: MW3PR11MB4572:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOlB9RgIJ6HfFMD5dzN0WpHZgaYWIjqCTwWLYDsnJwf/QlcdHV0uA4nF8w3pkD684GoIW4PG1g3rdkA1N3HWFEZjLrTnm3K6onwF2k5gQY3+M8k6+FbLXvRVcP43o/XISW3AV0XAw1Q91RxXzhtGcl/FxH+A/2b8ajvwK/uGL81I6wujcyX6QxJ9Hn9vGoyg6s5FgXdFm27+cFStEVODki4/PcoMe0+DRoFLsCd757qg8DJ3e5vOLQD+fD9mtoqt8cbhzFFQdcsAEv7cdronQ3En2e9y/JR31KBkxDUfVfG2xDRNZl77nNylAFOQ09cFKs1DoLmxyi/9PN9Z0HUEy4EWPLiaXR7PYgsCmfENu+SakuVegsYYHXC7J3+mbEpQT22mchP79dR1RtdpjhLArFTXu4wWKWTslRh2177I5OleACeWhYw8xymMTyoZn0kEH/Zq6apOWKeTFIg7yiSntEJwqKdo6iHjfn4U+/54Iw6NtgwTwPHAvjE/Vbc+56GR3h2S6ylAd7YwtgruqyeGUDDSgmGM72nBaeoi2SWt/ihbTTVzD5Ip7w+gGeL9MdYS2qtEmMdMUmMHcwiN5jSIlc/GbaDPGGKvtn01wrWI0bxVV2st0Ay3f+c48Q+pdPh3VSor61By9f8lMK9cSUnuDaCw95z5+1oj0v9L7VjNlgcxXIn1O19WTp4yIbxzLMngZkiOLYiULWF7TRtBpy1fxtnq1wwO9XQrsEOmNXMVY5rkrSyqWwpddLVTlosHL3zI90g0GMH2/Hw7IkynD3Vzcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(396003)(136003)(346002)(83380400001)(8936002)(8676002)(66556008)(66476007)(4326008)(66946007)(966005)(6486002)(186003)(316002)(7416002)(54906003)(86362001)(110136005)(5660300002)(478600001)(82960400001)(9686003)(6512007)(26005)(53546011)(41300700001)(6666004)(6506007)(2906002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mRMA/e11//UTebNIwqBXqXVmx4iYOXFZldTyf9FYKp6Y2elnGa1fMKCvF4MM?=
 =?us-ascii?Q?jEPz3620zbgDW2eT42bEL43tpl4h+j45FDlJguR1SmlUx+5W+NpWRmO0ojgC?=
 =?us-ascii?Q?iS79zzQIMiAjHTzyg6GLW2gItjNP5LW7tiIIzZf8PIV/Lg3BpDV7GlEOjj+d?=
 =?us-ascii?Q?IxPSqOHQmV1AM7nmlY2u5hPd085zrA/0v+Z4/q3T1vk1XuzzICoXi56QQ61a?=
 =?us-ascii?Q?2zL8B7kLkVTe7jbor8vbV2cDtRtLWhntcolA9H9NnSEBCQBeL9FBBDAdx0QC?=
 =?us-ascii?Q?JrLZb+hL4B7zpf9lhXdEQZ+nZBfSABydsrn6q5KJQ2ghu9DidxiBdtRcsRKF?=
 =?us-ascii?Q?xt/vXOtqgcXJdac0LFZj3fe+enhut1KA7Ut91KlXXXwMLyBDPT/KKnkUCKbE?=
 =?us-ascii?Q?sCDs0mYrbd7+dLQ39M7MuICark5kCiVfnfxH9BEk6wX73X5Apr9ApUAWT9PF?=
 =?us-ascii?Q?kirloUMyNhQ8sC9A44OHu2qf1U4nbE0ddd/vklFasoJBLWuYcVVE8a0H8EeJ?=
 =?us-ascii?Q?CpuaYsuumZEWSlH0bxp/jIvY8CkoC5YvnL2hmRxL3FX8TFea3UlezBG4Infv?=
 =?us-ascii?Q?pkqmmcoB7CpKgW2fxVaxREZTP826yGRNEOArQGlHw7EtaOvQeP3OVe31w0Ku?=
 =?us-ascii?Q?iHMqE9qyYRbQOCSh0QN7RuYlEPqnf8hoUDTF1+cxs4UIew0UA++kL3zA29yN?=
 =?us-ascii?Q?5ww7SUEGAswMjRIJ8X+mYomxuV692r4GpDYkaQ2SJG/pvASsdKETM25y9zzp?=
 =?us-ascii?Q?rmJ1YL/leYeUcXaGBcYOdxpQvxZwE3MJqrRZojAvCxz4vef8V0MxbqxJ1pVl?=
 =?us-ascii?Q?b07MVEq5fkRjvPtlX1wpAtQTRtLaZOJ3m4/MbPgPIH+lhE3jFz+dCz63eeZm?=
 =?us-ascii?Q?en5nW8X0/1WrSfPkJ+Ju5B/TBXiEjpu+5y0sQozUZO1EJTN1uh+jWKM0NTHJ?=
 =?us-ascii?Q?TcmVx02Mo2wkf0Ot42MSEQ4RnYEO5qtmgc62YNyTUSJks/e2HFyBi61fGp5c?=
 =?us-ascii?Q?pNMZ0DshRdH8xHBX79aN2KgHa+L5+jjzjXoMksion09sx7Im9t9gb8yMA95H?=
 =?us-ascii?Q?3HFiEKdddQ1oAIwOVyUfHOx7VqgWFGxZuNUdLVghmklUSJvodKKy2nL6I+3i?=
 =?us-ascii?Q?h1JAxkNYMcEmcdrvWwoTQDGYOoRCvtKK3kECuJA1mOwGxDXYUu85eDZ/lZSy?=
 =?us-ascii?Q?Vw6IdIHheJq5kF8UXCv56SNPZ28lsenoQAXRsBdojPfQe9okuV8UzbP1krmN?=
 =?us-ascii?Q?boEmqIompaPYD5QjdZaWb4GVJRwHGFrIRf044RnVqtM+CFfxT5ZbfaVNMgZ2?=
 =?us-ascii?Q?ZN6ed+TStMj/O4aZz/yHnnXhc0CKK1YzZpA74DX59a8g4ax3fjHJpYK1GJCK?=
 =?us-ascii?Q?3aIiEn4X09/+MH2sK7zbDZWpf7/0FLyhXn+njP4nFCO+oyRKMIYRlGf8F9Xb?=
 =?us-ascii?Q?ht8OHYwtFSL/oUvJ5FE4NHsPv340NsbL96oJEMmystiVjs1hvQ7sDhQhGQQU?=
 =?us-ascii?Q?2kgLja5mWaYOiXKZv19ZO6hcM02DRU35jkCcDi3pSUQ8dNzU5RNsTRvpIurx?=
 =?us-ascii?Q?AVxzeRiXld+jp/hdEhS8qPi+9hZ3+HhtzXkADsiMMRbA99ec4q/7PDKKzX25?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 510444e2-7504-473f-7f03-08da7995f88c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 23:30:25.5735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQOb2MczMTnEjLGtpmHat5WWMbvID6OjlKWxsEwAE5O0NmJc08PdwBgvqLqGwh88GeQCsaNVjU38eZNXHS+SE7Ky+4pfq8aKv3nYXzwBEUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4572
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Jane Chu wrote:
> On 8/3/2022 1:53 AM, Ingo Molnar wrote:
> > 
> > * Jane Chu <jane.chu@oracle.com> wrote:
> > 
> >> With Commit 7917f9cdb503 ("acpi/nfit: rely on mce->misc to determine
> > 
> > s/Commit/commit
> 
> Maintainers,
> Would you prefer a v8, or take care the comment upon accepting the patch?
> 
> > 
> >> poison granularity") that changed nfit_handle_mce() callback to report
> >> badrange according to 1ULL << MCI_MISC_ADDR_LSB(mce->misc), it's been
> >> discovered that the mce->misc LSB field is 0x1000 bytes, hence injecting
> >> 2 back-to-back poisons and the driver ends up logging 8 badblocks,
> >> because 0x1000 bytes is 8 512-byte.
> >>
> >> Dan Williams noticed that apei_mce_report_mem_error() hardcode
> >> the LSB field to PAGE_SHIFT instead of consulting the input
> >> struct cper_sec_mem_err record.  So change to rely on hardware whenever
> >> support is available.
> >>
> >> Link: https://lore.kernel.org/r/7ed50fd8-521e-cade-77b1-738b8bfb8502@oracle.com
> >>
> >> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> >> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> >> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> >> ---
> >>   arch/x86/kernel/cpu/mce/apei.c | 13 ++++++++++++-
> >>   1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
> >> index 717192915f28..8ed341714686 100644
> >> --- a/arch/x86/kernel/cpu/mce/apei.c
> >> +++ b/arch/x86/kernel/cpu/mce/apei.c
> >> @@ -29,15 +29,26 @@
> >>   void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
> >>   {
> >>   	struct mce m;
> >> +	int lsb;
> >>   
> >>   	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
> >>   		return;
> >>   
> >> +	/*
> >> +	 * Even if the ->validation_bits are set for address mask,
> >> +	 * to be extra safe, check and reject an error radius '0',
> >> +	 * and fall back to the default page size.
> >> +	 */
> >> +	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
> >> +		lsb = find_first_bit((void *)&mem_err->physical_addr_mask, PAGE_SHIFT);
> >> +	else
> >> +		lsb = PAGE_SHIFT;
> >> +
> >>   	mce_setup(&m);
> >>   	m.bank = -1;
> >>   	/* Fake a memory read error with unknown channel */
> >>   	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
> >> -	m.misc = (MCI_MISC_ADDR_PHYS << 6) | PAGE_SHIFT;
> >> +	m.misc = (MCI_MISC_ADDR_PHYS << 6) | lsb;
> > 
> > LGTM.
> > 
> > I suppose this wants to go upstream via the tree the bug came from (NVDIMM
> > tree? ACPI tree?), or should we pick it up into the x86 tree?
> 
> No idea.  Maintainers?

There's no real NVDIMM dependency here, just a general cleanup of how
APEI error granularities are managed. So I think it is appropriate for
this to go through the x86 tree via the typical path for mce related
topics.
