Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB88F578A98
	for <lists+linux-edac@lfdr.de>; Mon, 18 Jul 2022 21:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiGRTW2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Jul 2022 15:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiGRTW0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Jul 2022 15:22:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3E82F03A;
        Mon, 18 Jul 2022 12:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658172146; x=1689708146;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=eo3D0aeBeJw2UIM3nA8YbDz/YEqpnZylI1xwFHzdsbc=;
  b=N8mkV01X5dKmrHF1Gp72HLz6L73+MR7xuZybZQRIMYjHkbylW/MlL13s
   OkQUatI/4aeeFokFZuuGZWHieTRV5oFgl6dD51lJyqIF9rcO+lOmfxBeh
   AVqlPwL3zTWvCq2AurC8t4n3BtMwVWtlv8PuByvtHFqE+JZldG+aRAvhR
   2hD9Skk+qU86sJ7LWVJ8TzD9eEm87N6VLXdxCwk6mGqB+XR7cH1quWF/R
   SsDJ9vTeK2UP3R9+j5cnDeeqgetAN/BtyRXFrU+ofkwUW8kDtZdLS5Dej
   8S3wXg+3MMcokoeDrDPiKJwFK7Ctdc5QAEI5uHSaOzK1QB0cXDLmTUrFv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="266707821"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="266707821"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 12:22:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="572540502"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 18 Jul 2022 12:22:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Jul 2022 12:22:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Jul 2022 12:22:24 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Mon, 18 Jul 2022 12:22:24 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "chu, jane" <jane.chu@oracle.com>, "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: RE: [PATCH v3] x86/mce: retrieve poison range from hardware
Thread-Topic: [PATCH v3] x86/mce: retrieve poison range from hardware
Thread-Index: AQHYmje+5joA3gBAok2TIuU+DOldN62ETyBggACnK4D//4xNwA==
Date:   Mon, 18 Jul 2022 19:22:24 +0000
Message-ID: <797a2b64ed0949b6905b3c3e8f049a23@intel.com>
References: <20220717234805.1084386-1-jane.chu@oracle.com>
 <41db4a4b17a848798e487a058a2bc237@intel.com>
 <62d5b13b2cf1a_9291929433@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <62d5b13b2cf1a_9291929433@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> It appears the kernel is trusting that ->physical_addr_mask is non-zero
> in other paths. So this is at least equally broken in the presence of a
> broken BIOS. The impact is potentially larger though with this change,
> so it might be a good follow-on patch to make sure that
> ->physical_addr_mask gets fixed up to a minimum mask value.

Agreed. Separate patch to sanitize early, so other kernel code can just use=
 it.

-Tony
