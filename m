Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8031578A71
	for <lists+linux-edac@lfdr.de>; Mon, 18 Jul 2022 21:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiGRTPU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Jul 2022 15:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiGRTPO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Jul 2022 15:15:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF832F037;
        Mon, 18 Jul 2022 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658171714; x=1689707714;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=zfAn5AKoLGnNOzaW8CKNABTzsWkyD78MJy/9gkKbv0c=;
  b=dTQJZJzqT+ekdOU2URhRKP9U6tRMNcz1EY/SrsaW5pnqOlJyM9+oif/r
   aAG3YMIvcOp4p8i77FHo5fa3b14XE+06f+wvt8A+/7ZdNnTNQqy4aqv7Y
   h5wWIz2qCiH5H+PXb5w1q2onMVaXf416JhdE9nWnHEkaxfncaM79hGHke
   mAoilXc0mQI+LayLaF3VPBA0hKzu69S+IZduhtYPXuhUDjGtMMWLn2y+D
   Yi2bBGtImsg26AsB3uY0ZMZIgcyxsBUwgKSLr6ijIiA/6zHC9MgDdIj2Y
   KUo30Y1lnvtxtGJLVCCgMDRdWp4a/wYq3aWGbWmPVFgawxj65XYwXaWAT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="285058619"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="285058619"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 12:15:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="572538096"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 18 Jul 2022 12:15:13 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Jul 2022 12:15:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 18 Jul 2022 12:15:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 18 Jul 2022 12:15:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9l1iXdWgBtX7yL/JWf+MBGOskOBpNkfRt8k4wHToBQ8tn/TonFe1xMviDKa2NasxFP/l1ZUeVuGN4CRoPOglAKT0bWFfRnjzLqRWKRcQ0nwaZFIDm9R6SuL+XPDr6i7Ezsw/vuBzrvzHZY90TYv9K02qKNDzauM4i0Ka2b+fEekuXp+k7LLE+edltp1fi/Ph+0SXKIiTh3E6arbj7GWyZmKeyHHxv8CYhrm2a0nWemxn4LyU2CdjTLEtzWpPQFjGAXu5YMamppsMISZ1qckQ7Bp/WI6FV4qALj1e9mXgoWfyD7Ad0IDQCiqHYE9mPgDUfLw1no/f+xD9ir8WOod6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hj7wxCZ9+2/smp6sv8Xeax5fD+iGWFN2FaEIpyh3bI=;
 b=S56B88czFZA/FefVPBdeWi2gWqwVlTCQc829wES62Jl/tpIEG1n+d7IfjpuhBxyNBtC10oXsRlbc01PuWiS2GSLPyx/cyPWuxOrQG6+mr8r9m+gMVaSmNn6+V/lL7/wbEtB9PW1MSJDXdcnFHPuUiTLIh3Fos45mThWSpVn4KkhWYHV+WwPpjWjWCJMMVk6YXmRha9NLTi+DHdP4qheGShqWLZsBfNBe/uKwBI8O8Mkysf4T9gkdYBk1kbgiCHPZzSddj66R8WYjhqefsujNjh4dC5eCBZPdDHbUhdxxSFwEQFv5dB+TmBzuC9CIIXyCPhQ5W5IL8n1hb1LySAi+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB3613.namprd11.prod.outlook.com
 (2603:10b6:208:ee::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Mon, 18 Jul
 2022 19:15:09 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.023; Mon, 18 Jul
 2022 19:15:09 +0000
Date:   Mon, 18 Jul 2022 12:15:07 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "chu, jane" <jane.chu@oracle.com>, "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: RE: [PATCH v3] x86/mce: retrieve poison range from hardware
Message-ID: <62d5b13b2cf1a_9291929433@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220717234805.1084386-1-jane.chu@oracle.com>
 <41db4a4b17a848798e487a058a2bc237@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <41db4a4b17a848798e487a058a2bc237@intel.com>
X-ClientProxiedBy: BY3PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::11) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eea127f6-6b5e-4d7e-92ba-08da68f1d4ef
X-MS-TrafficTypeDiagnostic: MN2PR11MB3613:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3YovRxTLNgc3T0CRb23MbAh+x4R2X+V8L2EK2yd3OPIGsc26uPq8OzzhvDs+6ZcaLP91l+W1KWiVMWBZeppwgXDp3IgkUaewyhdht/gJBPTeOESzCrzKuJqoLLa9jeJeYrd9vQw5HD1kcl/hxvtYDoSQKGRdpbIMXtlId+iL9AlSQcrqrJfHa4+lWfaPtz6LPiN6RxHHcBdXKg1AvnpcAYe2JhDnsr5PJ33tOcNKBHyqM5Ynwk4IKFGAJ89XkCsuaf7bE/tkmVPRhok+X6D7xM2j8GDGzSqqzsTMfLRms/mbyAWbElQgWKb3DQfeURYIT5eR0SIVsUPjUAwBAobjaV3BpgfRgS0ZuX35676t2QU863mH0vnBWnwhVpaXqmIC3IlqmfPHPgnKsR+3p3ri+2EeQXiQc8g4CUsAtbLVZlPcT5Vk1hrB6YynU0LOE6RgRKRUMOSgvTfCjiYdwT/QnX+ofzp9UaH+qgczl5n0iOdSTz8n//XesvMIh13KqVl1K9A+b+FsReqzafqgDlPHl0HVmt2q/ErYtHkZTB8BqDDOEF2sd2RKaeobh+vfyO83R10nB3GrqXVA793Hj4v9WI+pVulEr0NiJzi9LMCoGVm/T/E3m6xKmViVy9aLdKK12qnkhF8zIFs38xZVYhlAkaw6/nxgYSwewpnV1UmQ5EazKOOxyidIEWkNmhLqKp21w0N10UPUxo57Dc55ir8Dpu/WIQn+h/Zx46zNeYBtE0WNXCXuhRQ8ShwtydREuaJWy1N90dm7PIt9jB+EhgZCMo8xW6cgbQac1yfyh6Jofo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(136003)(396003)(346002)(39860400002)(83380400001)(6486002)(478600001)(921005)(82960400001)(41300700001)(110136005)(6512007)(6506007)(38100700002)(316002)(186003)(66476007)(66946007)(5660300002)(4744005)(7416002)(8936002)(66556008)(8676002)(9686003)(86362001)(2906002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?otMCiK2WQSQLrxA53S7Z4/hiwrw3JNwcPM5V3D9mvkB28xx0acMbCrIJOi7k?=
 =?us-ascii?Q?1iKSLuVrjieRKT2JfEIaOi1rcvHakuMypnBXtlgAlH4eBxr2CfA0SOvZdwyL?=
 =?us-ascii?Q?3q72JVPam0mkiy9rVPq4W3jmIT0jO5w7gp/ZeSpGmgLoC9MQgWNLtNMaMfQY?=
 =?us-ascii?Q?Z0CkLD862ZHWhiJZWwjARW4xWeKPTfeXybg9ZCTvdqYt6FV++5hFEKQ+GFsc?=
 =?us-ascii?Q?kZxT1h1NjDkj2U+U25Rda6dRv5xLdRfXuSVpnTdjo8rmi/5QDHmqwrb7wWw0?=
 =?us-ascii?Q?SDmjvKZAGjinTkD3S/xwbtq5Tyc1p1S4OPMGE8s0/RA94ynBCJuy/dW6VxhS?=
 =?us-ascii?Q?5wrAeR3SLgZ7TBJZ0uddhKgsWWnNwwD7rfLkCy7LzhgoEAy5biQQ2SGffPMl?=
 =?us-ascii?Q?c7NnLroGwX/iaHHbR0MFWRGaq5iijgf59oxE9wJJyqyZajKVMTHtcsumFL+j?=
 =?us-ascii?Q?GMFjs3dX38ec0pwij4YxpxCq0wuiWnpgnR3Jhf6PtkQokmhVy7aXvaeveOkl?=
 =?us-ascii?Q?9xW17DRGEh6LM27i7rUcZpXv9cZPc6Zo6PaFbmi78eaQ3yFpXf6cPyWJ4DWK?=
 =?us-ascii?Q?+8J4xwKFUnPTNgAprgbB6Y7CVJyOSh3+s/+5LXOEJflA8XvdyGSZ1EZNgbGd?=
 =?us-ascii?Q?YwNPtfK1W9VlafBu6giG9+3ZC27J5ClS0g7j7XSq+8O+pX9A80IMhkdDVNhK?=
 =?us-ascii?Q?6Kxs0FgPjuuAAT7R9qMnKw7ZoR8ZYXUfqOZbCb2sgYd+5JFVCXhMItYHXRLt?=
 =?us-ascii?Q?Lu1ZsDnpkGUje+0WRkBsikouS7uttcPZqcFh+sX1/lrCrsHa4vLg+EA+V154?=
 =?us-ascii?Q?5KtHOMiv3PwHfp8Bj3V4GIjFYZYrz9CO4HfRpBWCpaaPnM/EGVF3XPag8nCR?=
 =?us-ascii?Q?rFmvSHW+T78FQiRXFfz14+9KSoHakCa5e0NPVaNmJSs1luwT80gSANYEjg9z?=
 =?us-ascii?Q?VigShVuSSo8LFaSFUdZxsVmry1WgqY9FfQtXQnUCh7R4xmL2cN+3Vn2xxIVe?=
 =?us-ascii?Q?/Y5SQRubSYFSNFYWwdVmiknCVT+/OeUS1M1gGH8JV7+yvokSprq0wj2B5btx?=
 =?us-ascii?Q?5JUgKFRxrHIbZXsaUc4pwDY6BOcmLaUh3+SFjDtiUlxR29HecGRJStY/1onC?=
 =?us-ascii?Q?l3qufTonIau/BhkSOrkMOVCeEcwbMCOXimmsZKFM/znku/XUYD34jII+ZriQ?=
 =?us-ascii?Q?YvBp7WTCgOJQPSnq3djT95sEr5bYLlK6D/t3bM/ACdxtBuhpyi71x2+3ct3m?=
 =?us-ascii?Q?MbIamJ1DsFnxrygN0cPXAndylaMieJrADKnWzQLjb+HXAj5uar2aB8Ph2Bg+?=
 =?us-ascii?Q?n6nwjGs/Q4SnsCHOoNU49WkdGn0GxrFCaiDO3uWUsE5ojY1Qpq5keZM9Foxk?=
 =?us-ascii?Q?Pf2vr+bEm44Rw2Lpm5DCECIxUiyh1NobD+ZhBplKoSx1lrB98+Hcbtin47qz?=
 =?us-ascii?Q?W0z+9BKee3zVlYqWi9qO7yrIN2XC85ycphI1nydb+CpZzkrKyaI+J+Da9yEx?=
 =?us-ascii?Q?hs8FCxEpQQd0UbTRW0oBEGdQyQ5M9nqnVs5YP1NvX2WykMP38alOwyzvi4ix?=
 =?us-ascii?Q?4nA0I9rCiB2IjahQP1QtdfFgNteIoRWOp0MTc2lKf29xRVQy5Zbg3eTIi7fN?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eea127f6-6b5e-4d7e-92ba-08da68f1d4ef
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 19:15:09.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFUywQJBE0QX1Zd5zNrMI3mxXsoqD2IvWzJ31NLK7SguLGCyEl04zaWfgWkdEnOlsQ4lxvgLnL5DzTpkurqpxhBzlrROXBz+YCg4hbu++c0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3613
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Luck, Tony wrote:
> +m.misc = (MCI_MISC_ADDR_PHYS << 6) | __ffs64(mem_err->physical_addr_mask);
> 
> Do we want to unconditionally trust the sanity of the BIOS provided physical_address_mask?
> 
> There's a warning comment on the kernel __ffs64() function:
> 
>  * The result is not defined if no bits are set, so check that @word
>  * is non-zero before calling this.
> 
> Otherwise, this looks like a good idea.

It appears the kernel is trusting that ->physical_addr_mask is non-zero
in other paths. So this is at least equally broken in the presence of a
broken BIOS. The impact is potentially larger though with this change,
so it might be a good follow-on patch to make sure that
->physical_addr_mask gets fixed up to a minimum mask value.
