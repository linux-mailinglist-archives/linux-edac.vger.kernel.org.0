Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F26A5845F3
	for <lists+linux-edac@lfdr.de>; Thu, 28 Jul 2022 20:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiG1Sq0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Jul 2022 14:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiG1SqY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 28 Jul 2022 14:46:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F956E2F8;
        Thu, 28 Jul 2022 11:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659033983; x=1690569983;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=TKRfF3LGWS6pgiljeDhCNGq9i9K2pGTPs8zS5Ph6EGc=;
  b=Jz5+J/bw6U9sHxR7yKlzXfBF3tsqqo7frRGt0KgdYMh84XYbOLfoZ/cK
   ddkMaFiShI6H5wfGDCpNTkc648BJFvL3lLOkJwba0IQsJU/yaVgqSYFbq
   HZGonaZxC6jF+0yBywMGHPaPx3TJdaVksCrRS8VfH1gFZDa+lEL3qToY5
   e1ffnbLMMRoUV/616uCtzVkyd2046Mrlhaupn8uJMizkvDr/RKYu7rKQ8
   979gdPy/4+cCkiNFs42WnTQuHbbGw8nVB6SkjdFzHl62ide6kd6er8Krh
   QR5mEXhsfKDwK0/ZusumN7rqUaF2Yrdl1xVYNyZ7LVx+IpLaYL9gSf8jE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="286139931"
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="286139931"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 11:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="633822663"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 28 Jul 2022 11:46:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 11:46:22 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 11:46:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 28 Jul 2022 11:46:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 28 Jul 2022 11:46:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgPkQIFCAdOSvZWkgcLDO7xd1HO441JPKNhpL9pL3karJuPdccpmp3RuxAp7HL9Lgtr/2CViVIk064Te8gFLGzU1MaxH7sw/M83yeXAHciFQx5dI/AvE3CJnhOF01Z6iMxYkeRcSY0VZbZIsgnlgp+C9JnBIDQqtj10N+AIvxTCOQNhAWjc0ETVAZuJORMqEiyeXbvcEVLUPI74odf/14SfPgSSciSCpS0yHYnRyTdC/8d+VBmK66B82qwiMmbD3ZPwXrdsvxgEraShKGXqgml9FgIJm/UsO2YMyV0eKiwUCxbAWsArVN1s0lcklNmMxjgehaSMnvXQUahsExHnzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7GogpTsy9EqTjaaLZT2bUTwGo85xusprHuAvCR/4sI=;
 b=TVJBsHWwYvIcpUD/HT2JldEJ0gmyNCgu5hBM8VX0CnJ/lsD9p5iHzbFLGeEzD2/BPYHOtEOs2l30YTRUlgRJAL6xMamGoMOchga6uiMx6SjWahfKgoNR838cO47JdRoP4ZhjIx2Gk5mMUa2BNOaPO1SaQnbCrj0LDga/CW/rzxG4tf8uNwcLuU1+/zol+y+ns/t1e/0U3JO3YTDE01aiRIziRbJESwuOFB79cvfy7qGvTIT9+a70BiGZJg6vgBpHfH5E7B7VGlhb5pDzHQ3QMNB01bryuc8FD0jMoo1nrpfJp3AJv9GAgw2SeTVEx1Tks3PkvbuGRsUUiN1iH3vyUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CH0PR11MB5740.namprd11.prod.outlook.com
 (2603:10b6:610:101::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 18:46:19 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5458.026; Thu, 28 Jul
 2022 18:46:19 +0000
Date:   Thu, 28 Jul 2022 11:46:16 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jane Chu <jane.chu@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v4] x86/mce: retrieve poison range from hardware
Message-ID: <62e2d9784bc58_37b17529451@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220727184644.2685405-1-jane.chu@oracle.com>
 <62e18a687aac2_2d20792944b@dwillia2-xfh.jf.intel.com.notmuch>
 <f22faecf-b4ea-cb39-bed3-3647842b814e@oracle.com>
 <382e9410-d964-5600-4481-ccad90dbc97b@oracle.com>
 <8e817134-bfa9-72bc-3601-eeb1a138fe37@oracle.com>
 <62e1999b4121e_2d2079294ea@dwillia2-xfh.jf.intel.com.notmuch>
 <9ca37489-e7f6-f619-c9a7-a1d9665c477f@oracle.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ca37489-e7f6-f619-c9a7-a1d9665c477f@oracle.com>
X-ClientProxiedBy: SJ0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::7) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a94414e5-addc-43da-17b8-08da70c975b1
X-MS-TrafficTypeDiagnostic: CH0PR11MB5740:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDEwaiCCwvDA/AqxAWftqmesCpYXDVmOMgYZW9kwelGPuReri2UkQxoyY/E3KlbfJS9Y6RqAh0tLLrh0XBtctSIOkgbbHavNjZFmjtnc115uRr5a+HNd1cCIY7kGjLa7KOxhHoNgIa2XzAufbZCg6Nem7bH9vbvgAO7z26ElfoP9YUD0Ql+8MVtvCC9bfNgO1NKoAxlzaatu3mfBptBTXX2mYESKjBsWB4pPMBEquyewtwxCcf7Xe4pO62Smwc3IddaSSNKORMl9NYw8/wNr3HoIv/hz4GObHX4bKbgCflwr1EXOzTBZ+ZWbmvy3uaDEXNpwKxiMdNoaCZHLqAg9WMXroUsv1iKgmRDDhidT5r8UOJ8DjZb0HNNo4+lpfLl4AjB/ZQaMxLcBsm0b8negUi6MjLjWnsUzog5+nVq77vFILtsjAbkwwaixtNrD97n8dsUy7WFo6pARI1xv1fHr8scSjpdUmTg/OvqaMq418n4LUU5nw/54GKm0d5nC2oy0nEAHAwN38glDhw1Ii1rs8BPaM2SgK0OQGyTU9+j3IlI7t0b62qqboXqyJFYqw4Xbwv+PV7jhAKslF8Ln2+8StGW2VshXOzJddftynM+H6cQCiM7m4rmsPTuuMUTXOA7Sj4mZOiWfek0st4/7X2fGxzxry3NjOySPi9SrbgvRRwfUNERrEi8DugeHFSYwAEgdofxUWUxmZyHKcR3ak0iIoMmJ5w19CIHbMh8lvg8W2V0o3tvI+mB7iSgIunk58RIcsOlJXWsSfCV89kDloxw8lBWPgNIDBH7qqTqUYW26XutaNdhyMw5+lt0vrJEY8FONnVMA8wxztuEnGqAO8pTEIAhwhdHZan/8Vl9Gr9Zp9Zg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(346002)(376002)(396003)(82960400001)(38100700002)(921005)(41300700001)(5660300002)(66476007)(966005)(7416002)(8936002)(478600001)(66946007)(83380400001)(66556008)(8676002)(316002)(6486002)(186003)(53546011)(6506007)(6666004)(2906002)(110136005)(26005)(6512007)(9686003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4z8M1I4ue3yhSAKtU+Dc8+QdSQXWMIGJZHk3VDGqdQU7a1amqmy0ITaaoR?=
 =?iso-8859-1?Q?EF87ihu1gOdP4XjnvOUmOTIq7l0o69yPWghMIQObLLjK4EijDpyq6YBZTI?=
 =?iso-8859-1?Q?oyy7KNsJHL72ch6hr2bieXa0OpggfhsD+kbxl7vm7FDNlQ4BDCQ0ls7cIS?=
 =?iso-8859-1?Q?0OYMl7LHwDySbFu9KbUtFck1YKJAU++2JMuJy3FJXUDvIPUSx7yKRq96ZS?=
 =?iso-8859-1?Q?iD8C9QAWtHwgpGbUVi18myl1DdetFhF6tmCC3q6i1j9vCNGhWV1byqxsbs?=
 =?iso-8859-1?Q?3oLHFZ7P7e6JJ+fez3TkGfUGZN5QrwrI9G7yA1ucOC0/SXLUN0LBMyMrjx?=
 =?iso-8859-1?Q?2er2XvlpBgD23Y7K7mJeArhjH/1uBe87rJuxeyK+LImgE7YLjiuWx+ZcSh?=
 =?iso-8859-1?Q?zv5yso7PFSy7Yi1BZchWgR6iMRc7g2AKn4X2Owp7uGS+1Nh8D/6jVbgYqz?=
 =?iso-8859-1?Q?NSkmLqZQCRZ6YZCJ8h1zjtUKul5E9e7yelaLrcMNQaCTtiLE/rsNt0bhyw?=
 =?iso-8859-1?Q?1LjFK+toRn+HHuxVNL5lJD2ykQblLwoqV7KQYuqIhgREIA6TMocC3EVcrk?=
 =?iso-8859-1?Q?RRkG5AeUMDPoKjjvzz/DBqq3v74eCP1gKpP3ErI6JB0nRop30gDpA65CSj?=
 =?iso-8859-1?Q?fiEDrI8VT96t4ZuQ11Pyw9A82B8P6lUozXXzCmHxt5E8vU2sszhfM9Yomg?=
 =?iso-8859-1?Q?b9kiCPz4snT5XK0HM2PFZCMCH4qJGxW9eXvs8y0dHPOEX4VhZ+sUB98b5B?=
 =?iso-8859-1?Q?Dxq0WdwQFCaqQlgU4aHxKdQYV1Cl0M39F9OQIADQQFJ+T4zDtR1JCD+aDg?=
 =?iso-8859-1?Q?CZvx7irVNGfgI/zXII2EjipoDDtf4m3cyeON/xh6ObRWwZ6Q2rna09LS18?=
 =?iso-8859-1?Q?hugaFfeDxDrnknPa2a1JfUI/CEBlVoGteLlaeIAndMMK1Z04xjzxOa9ljc?=
 =?iso-8859-1?Q?X7XBWVAlSwhROjY8tkrUuv3Qz1tPm4t5+3s5+9GLebN7+dWa5H3IDo7d6e?=
 =?iso-8859-1?Q?33e7d3FGsV6wv2jthUlgJPdwtpqYytN/Xu+Sx13GZGoweyFkQKAQBUp0/u?=
 =?iso-8859-1?Q?Q9tsYql1TLGiC8qjCz4hses+oDF0gnGFI5wF/sPC+o1SMmXfij3cMp6j6P?=
 =?iso-8859-1?Q?KAE/3gznVkyCZu4PQBxfmTfykEffeZO+OWNcfZzdmaSDPhSi0NDnCdAeq4?=
 =?iso-8859-1?Q?J1j3uP8LHrXRB1wq4CCHa0CsId2ebQD8tf8Vs+hEhge2+T7nH62W7KfNA3?=
 =?iso-8859-1?Q?hA3PeWElQWwhUCnZgxnLUOfw8X+NgNTwFUxj8X8Qgj7yz+hsmncdhhJUNz?=
 =?iso-8859-1?Q?5w0DY11CvxevYdTDjcWXjcGSQV32Wq/ulqrCSO9kK1kps7ADK2KuTrnOhU?=
 =?iso-8859-1?Q?4Apc5AgP2+RszlVCwF9WZUXaGcnMz8MtYVpLvYr+9AJrCMuum55+tj787v?=
 =?iso-8859-1?Q?BsXDPukmAHQjZmBAD7ze8mQ+26ijIxJNkZDUiR2veYyVcgP1sVhvgtYXPW?=
 =?iso-8859-1?Q?1qGISDoB+6HpKOG9IHQWbdjO9OwHZUdeCRFGVMqPg/6pPPzFSR9m7bSUTn?=
 =?iso-8859-1?Q?vx9LecewAAEinU6Risw63oz6/8KJi2eqoxuFALPvNAU3/202MM0Rcuw3Xw?=
 =?iso-8859-1?Q?iyItzRm1AepU4b6iBDxwbkOQ0wXnBKxSBSZNVlK4XvSteMTmfIlEqlBA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a94414e5-addc-43da-17b8-08da70c975b1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 18:46:19.3186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gdTcp0PzhfFju8njsK/22w0imXexEgh6p1xpOVSsltYUn8prv3SV6BoDv/x8m5uxCtosfZ+QED1nXSvf0Zm3+6w9wU23HFEFJYQ0m3BiyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5740
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Jane Chu wrote:
> On 7/27/2022 1:01 PM, Dan Williams wrote:
> > Jane Chu wrote:
> >> On 7/27/2022 12:30 PM, Jane Chu wrote:
> >>> On 7/27/2022 12:24 PM, Jane Chu wrote:
> >>>> On 7/27/2022 11:56 AM, Dan Williams wrote:
> >>>>> Jane Chu wrote:
> >>>>>> With Commit 7917f9cdb503 ("acpi/nfit: rely on mce->misc to determine
> >>>>>> poison granularity") that changed nfit_handle_mce() callback to report
> >>>>>> badrange according to 1ULL << MCI_MISC_ADDR_LSB(mce->misc), it's been
> >>>>>> discovered that the mce->misc LSB field is 0x1000 bytes, hence
> >>>>>> injecting
> >>>>>> 2 back-to-back poisons and the driver ends up logging 8 badblocks,
> >>>>>> because 0x1000 bytes is 8 512-byte.
> >>>>>>
> >>>>>> Dan Williams noticed that apei_mce_report_mem_error() hardcode
> >>>>>> the LSB field to PAGE_SHIFT instead of consulting the input
> >>>>>> struct cper_sec_mem_err record.  So change to rely on hardware whenever
> >>>>>> support is available.
> >>>>>>
> >>>>>> Link:
> >>>>>> https://lore.kernel.org/r/7ed50fd8-521e-cade-77b1-738b8bfb8502@oracle.com
> >>>>>>
> >>>>>>
> >>>>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> >>>>>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> >>>>>> ---
> >>>>>>    arch/x86/kernel/cpu/mce/apei.c | 14 +++++++++++++-
> >>>>>>    1 file changed, 13 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/arch/x86/kernel/cpu/mce/apei.c
> >>>>>> b/arch/x86/kernel/cpu/mce/apei.c
> >>>>>> index 717192915f28..26d63818b2de 100644
> >>>>>> --- a/arch/x86/kernel/cpu/mce/apei.c
> >>>>>> +++ b/arch/x86/kernel/cpu/mce/apei.c
> >>>>>> @@ -29,15 +29,27 @@
> >>>>>>    void apei_mce_report_mem_error(int severity, struct
> >>>>>> cper_sec_mem_err *mem_err)
> >>>>>>    {
> >>>>>>        struct mce m;
> >>>>>> +    int grain = PAGE_SHIFT;
> >>>>>>        if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
> >>>>>>            return;
> >>>>>> +    /*
> >>>>>> +     * Even if the ->validation_bits are set for address mask,
> >>>>>> +     * to be extra safe, check and reject an error radius '0',
> >>>>>> +     * and fallback to the default page size.
> >>>>>> +     */
> >>>>>> +    if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK) {
> >>>>>> +        grain = ~mem_err->physical_addr_mask + 1;
> >>>>>> +        if (grain == 1)
> >>>>>> +            grain = PAGE_SHIFT;
> >>>>>
> >>>>> Wait, if @grain is the number of bits to mask off the address, shouldn't
> >>>>> this be something like:
> >>>>>
> >>>>>       grain = min_not_zero(PAGE_SHIFT,
> >>>>> hweight64(~mem_err->physical_addr_mask));
> >>>>
> >>>> I see. I guess what you meant is
> >>>>      grain = min(PAGE_SHIFT, (1 +
> >>>> hweight64(~mem_err->physical_addr_mask)));
> >>>
> >>> Sorry, take that back, it won't work either.
> >>
> >> This will work,
> >>     grain = min_not_zero(PAGE_SHIFT - 1,
> >> hweight64(~mem_err->physical_addr_mask));
> >>     grain++;
> >> but too sophisticated?  I guess I prefer the simple "if" expression.
> > 
> > An "if" is fine, I was more pointing out that:
> > 
> >      hweight64(~mem_err->physical_addr_mask) + 1
> > 
> > ...and:
> > 
> >      ~mem_err->physical_addr_mask + 1;
> > 
> > ...give different results.
> 
> They are different indeed.  hweight64 returns the count of set bit while
> ~mem_err->physical_addr_mask returns a negated value.
> 
> According to the definition of "Physical Address Mask" -
> 
> https://uefi.org/sites/default/files/resources/UEFI_Spec_2_9_2021_03_18.pdf
> 
> Table N-31 Memory Error Record
> 
> Physical Address Mask 24 8   Defines the valid address bits in the 
> Physical Address field. The mask specifies the granularity of the 
> physical address which is dependent on the hw/ implementation factors 
> such as interleaving.
> 
> It appears that "Physical Address Mask" is defined more like PAGE_MASK
> rather than in bitops hweight64() ofter used to count the set bits as
> an indication of (e.g.) how many registers are in use.
> 
> Ans similar to PAGE_MASK, a valid "Physical Address Mask" should
> consist of a contiguous low 0 bits, not 1's and 0's mixed up.
> 
> So far, as far as I can see, the v4 patch still looks correct to me.
> Please let me know if I'm missing anything.

The v4 patch looks broken to me. If the address mask is
0xffffffffffffffc0 to indicate a cacheline error then:

    ~mem_err->physical_addr_mask + 1;

...results in a grain of 64 when it should be 6.
