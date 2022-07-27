Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB8958333C
	for <lists+linux-edac@lfdr.de>; Wed, 27 Jul 2022 21:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbiG0TN2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Jul 2022 15:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiG0TNN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 27 Jul 2022 15:13:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749BA68DC7;
        Wed, 27 Jul 2022 11:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658948230; x=1690484230;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=5S1+BfadPaBO4GnzmGqnpuXyC0awdWHjwsHwmreHl84=;
  b=m6O+ae5KvYhLzHAsymEbM18GGtEnEXofYkOzF6DWb/mTjgfLK4f2iKcW
   DmvLWQ6H2ynnjXZTxdBIOsy2VzojKnZfdjY+mkPxPq5Nbk0UhKBvIE4dH
   r5/nbfB+QE6Cj6RzX5a+KTYKxo0HTHW4LBebNmLRJHY481QWrokKf/eoG
   TjbzIu6zTrNCpybaSSDzQrlF6IdW59GRRUrU1szMhCj66WfPH7N2/QF2A
   rIV6n3xU6kDId0D9e2806nrjbjNfzeCMlkXMC8Pr4v5ofSVsQdu3oEOf4
   gr50577fK5+nYhaS5Bb/LjJr2QUvzGID3e0N2cD7fT9bnyxMMhlbLEBbV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="314103688"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="314103688"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 11:57:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="927912385"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jul 2022 11:57:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 11:57:09 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 11:57:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 11:57:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 27 Jul 2022 11:57:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SokMaKq/3+2MJL1AVHf47Y4R3l2vlUkyo3Mhl96x85uqhU+yq793pZK/6DOisqMguvVtTJVzQf9CAAqKj602gYhqSaczIXDoI/OdNUicYMyfUEmeShOo7l/apc6tDDmJugL9DfdNzF151FhPqNEynn5J+6EK2uackRLW8vqOaYyNBmAYGcP+q8QGnDuMyM6xdFlEn/hJRYrVzkxcJOVr6S84jS75sskGHjawKKOzHxopl3TxMcX56NVKEDfL7d7fsmch3Xc6nf4ffDldlvbajEOkMAX+ShQsM+xn7pBsYUfbRFljHk4/XvcNY2Zm8sqPpbzKmUJDMwXcN2gEUImkFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9m1/oQe0SQ7BugVyD6iCppQlSSAD9BMV7rCU9dmk5Q=;
 b=Xt4NkNAsHc09N5ovxZnKhu0s7XU+80Ldh/k0TtEEeVCYKKmHoPZ84aM/3Sl19GMCFHb6hb7zTEo1r2eV5UlyPXuuKtCDRLFE+f+7KqGhwdA4R+CdEonXb1C3bm1LeClgSpYFehIp9S3zQjhxNfDYD21klB9JCgks1bMfF7tkXGvXengRgMFydKdmAISODxqRqF4BzGZBipK7V8n4uNGT9dHYl7VGSKDajwguwb1jTcyEyTgqlJb+T3zmIQptiblja9nKgPY7o1NLRBhQLa4SV5qb+TmZiSO1vJMdVfg2vrvrooZW+S9v3wul0ZP0/6bHlqSYUFFRsG+vXlw1/pjP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BY5PR11MB4355.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 18:56:43 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5458.025; Wed, 27 Jul
 2022 18:56:43 +0000
Date:   Wed, 27 Jul 2022 11:56:40 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jane Chu <jane.chu@oracle.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <linux-edac@vger.kernel.org>, <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, <hch@lst.de>,
        <nvdimm@lists.linux.dev>
Subject: RE: [PATCH v4] x86/mce: retrieve poison range from hardware
Message-ID: <62e18a687aac2_2d20792944b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220727184644.2685405-1-jane.chu@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220727184644.2685405-1-jane.chu@oracle.com>
X-ClientProxiedBy: SJ0PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::25) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d19bce6b-fa41-4fbe-8da7-08da7001bf18
X-MS-TrafficTypeDiagnostic: BY5PR11MB4355:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5si7m1ZGsBWBtRcBpEajc77NefVV2Uob/ov0u+reR0m/i4TyR2e+E/e6g/aiTgUgYi5lMLiQZYcm3Y6ekax7xg2YKS88lh3kUiP5IXt0TBeRPf0IR7EL9Xo4a7imafvnzK1ozrFiHfEUZnvu0PXpDqwh8EZgoT7XfuX7zIrM0qitOv52IhaC32EocqLpF2Ju2O5XZY5044seXLzmLdimVInrg1cTvsfTedqu2c2VZl8vSFToVB7e4nDiiSMpGtHCk4ctpufumqvei/cUCtu8IS9pFAlnhd4zl6wSDQXwSs/gD1FAvcXQV1eHcWuZ6UX9Yzpv/aAXHpsWLphR+5xAFoHc8eVNGm6wUOKkMg8f3pipYZLw9EtLjVn6ru6J/img21uG0CpAeRDlY0WE+xCfQC6Vk9y01y5Dqf7Ixi5PBlnHVsSmgyWWOoHumpbFtH5ITIZLHpRm75nakHarCVUBNvLBypinwV+tNiAqWWhrs6jEScRXgOod6hn4HI0Cq8yqe4Wf29GXRDXMxKkgF/kYow7sqkprbYuJ9oKFYMC2zt+3pScB+Nu+Hqa8NYp0UwJC73q5LEQuzvlFxoAG3D/lVr7i59NaU9olbEMIBXWm3651vPFtgdKEcZdxvCin1BOlm2/Q75rrU/0q5UVRnpjZHOhJ8KCvgYhBzzgczXfUZiSfzRaO6QjkOOhUZPv0teUF99AshvLBE/x+zQezAKxQ/UJ2PESOJR8hFu1ZLKmHsNds4yWivyqGccT/IFsR5Tt3kbbF0dIjQN+0yulnEKR/HsBG0whOj6cIdoIRDwoIzpEKyhUQY0k4YTGoTOdK/Bi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(136003)(376002)(39860400002)(6506007)(86362001)(41300700001)(316002)(478600001)(38100700002)(2906002)(921005)(83380400001)(186003)(966005)(66476007)(66946007)(6486002)(7416002)(82960400001)(5660300002)(66556008)(8676002)(8936002)(6512007)(26005)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CHmV0Y0ce09av9R+VLUvytvrzFwJ0EJnl1q9o116S7S8QT+MvsTS8YWFBYuG?=
 =?us-ascii?Q?0zEnv4uCXqBvInS72jk7NqmPPpHrHICMA6x+0qUKZ3JX4ifMUIsDpLUwgAe/?=
 =?us-ascii?Q?iPFWcwcKI7yi/RvYb7hUOlWiNsd6KEYRDa396eeMeUZP4iNtOcQY8OgTq8tY?=
 =?us-ascii?Q?dJs475jzpZcyiSrM9IkMKhKZkz5FPQRLLP2fYM6PeLL+zkXBTyF8RLV6tlrx?=
 =?us-ascii?Q?EF0pWd2Nwpl6UW/ep7VS3XAb3Rtga/jCs+azYNOc/MAStu0C0ZuznlCsyqv6?=
 =?us-ascii?Q?8mYNtZljJ0SQmNK+/NpNivSSzpLFqM67Atb/6HmcraEN3si0zg6Ylp8KB1uo?=
 =?us-ascii?Q?WUl4p5n/1s7GGmdcvVKkLbtwK/4yu1JvbfGIW0BAYf3it7s//WtgVs400B6Q?=
 =?us-ascii?Q?p4xt6wb1QRhuUhoZzLW1Gz7bqNUcDIFfe/YgHU14os45arjzzceihxLOPQdD?=
 =?us-ascii?Q?voFqkXru57R3vlRZlM0gp4PYCtenMHZjxvQYLQWgxOZo4XzRdj/c7G7J0NNF?=
 =?us-ascii?Q?MkxPXixCtIZnljS4nRQD/KRRjmIWJ9ZE6qxtiCLwrUuAdaAiSXE+VpQ5rh1c?=
 =?us-ascii?Q?OpJzQGVdF5vO+mEAmmtTsTPASnFJhbSQHg5yAvxzwgCc1I6YmFF4WElhSOxq?=
 =?us-ascii?Q?MiPZ0wyXKLXm9n6KjowVNArQmJxdBCkX+EctdXukRdmtxxh01UEPOeq1uqGj?=
 =?us-ascii?Q?XPOAHybWRbNMH2YxbT3QOumxMPf5Cp2S4bQSRA5t4tvYm2aHmQCyqCvx4tgM?=
 =?us-ascii?Q?tA3r34K1kciNq73iapPX8wqCh+Y3Aq3WIssmRCRJSY6ndxE+NgBSUFu9IMKe?=
 =?us-ascii?Q?NigCefzW5fQ3EGirsMHL5YiGFDZMG0FSxJwdhb7AL5Fpg4gACt6jWWZlrH/2?=
 =?us-ascii?Q?OtUOWFP5YzOB0g7H91HqDUAgGmHNWmnhoZA35UBrd8RLh04QmDikAiqPIc4Q?=
 =?us-ascii?Q?2ApKOMk/bT7nXADaS4T10rBPXe8ZcZJ0pTX2VG1drGNWryvOvT2eMqJ6n1yD?=
 =?us-ascii?Q?ALIG6xjEuOkjiZTpCQ/drw1KME7uU0ZuNzNkPDqZ4iacCKOww5Og7aHFlU0K?=
 =?us-ascii?Q?4i4U7EKR9GQ8yw0ddPcUQ5FQLT9I03q4I0KdJAPaomLcW6Mn+NFUdpROrton?=
 =?us-ascii?Q?TQf+GB/VhIpTnqGGKx0R4SW5KHU30xKNMxYgfUSl7F7/L4qp4GxU7Lts2ML5?=
 =?us-ascii?Q?IiXdKgdtm5Il4zk0H362L+g7E9EpRRSCcmoccFnJ3+9U/CoJa1eaGRhcpJ72?=
 =?us-ascii?Q?wN7/sRoYgzW5mLlf7Rq3ONZ3z0Z22E3NpLUXnPUc97T1JeJa0s59UkYdpviw?=
 =?us-ascii?Q?yQq8vBXgQykeGH7Tcqcl5+gLdpLMt2Ag+OaIpbyEIVSar+D8yeVNNPbUh2Vq?=
 =?us-ascii?Q?U67flk1vC1V/Rf5hz29eU6PlPKwJ1mCXJDAvHGRHSMw4vfKozzo9lq7weRp4?=
 =?us-ascii?Q?UHn7PcOF2/FiSEIReOlF6AuAED9bQnc7h0Q6JQhA5PnEhbZohMzwAx1StXP0?=
 =?us-ascii?Q?uPSguJ1/6E4mfRMV/2ROsiGINTtyGRtzAr8WFfdhhjrUx/OSWZVj1YgLQ8se?=
 =?us-ascii?Q?H49lj3ex2luWBeOVBCFgE1AtKXpYY7LWnITgV0wq3nlM3460D9PrTsRCWC4p?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d19bce6b-fa41-4fbe-8da7-08da7001bf18
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 18:56:43.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5JlaVN9DcxYnW2E6DfFh7BGMI4ZzNyzTeNRs9t6JEYhucpVQq5Cd4lWoaN0SBlNPDj2tvy3zO9bnhLLTh9rsnw5FKLme3QmFG8Fjvft8/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4355
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Jane Chu wrote:
> With Commit 7917f9cdb503 ("acpi/nfit: rely on mce->misc to determine
> poison granularity") that changed nfit_handle_mce() callback to report
> badrange according to 1ULL << MCI_MISC_ADDR_LSB(mce->misc), it's been
> discovered that the mce->misc LSB field is 0x1000 bytes, hence injecting
> 2 back-to-back poisons and the driver ends up logging 8 badblocks,
> because 0x1000 bytes is 8 512-byte.
> 
> Dan Williams noticed that apei_mce_report_mem_error() hardcode
> the LSB field to PAGE_SHIFT instead of consulting the input
> struct cper_sec_mem_err record.  So change to rely on hardware whenever
> support is available.
> 
> Link: https://lore.kernel.org/r/7ed50fd8-521e-cade-77b1-738b8bfb8502@oracle.com
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  arch/x86/kernel/cpu/mce/apei.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
> index 717192915f28..26d63818b2de 100644
> --- a/arch/x86/kernel/cpu/mce/apei.c
> +++ b/arch/x86/kernel/cpu/mce/apei.c
> @@ -29,15 +29,27 @@
>  void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
>  {
>  	struct mce m;
> +	int grain = PAGE_SHIFT;
>  
>  	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
>  		return;
>  
> +	/*
> +	 * Even if the ->validation_bits are set for address mask,
> +	 * to be extra safe, check and reject an error radius '0',
> +	 * and fallback to the default page size.
> +	 */
> +	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK) {
> +		grain = ~mem_err->physical_addr_mask + 1;
> +		if (grain == 1)
> +			grain = PAGE_SHIFT;

Wait, if @grain is the number of bits to mask off the address, shouldn't
this be something like:

    grain = min_not_zero(PAGE_SHIFT, hweight64(~mem_err->physical_addr_mask));

...?
