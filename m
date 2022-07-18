Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6404857871C
	for <lists+linux-edac@lfdr.de>; Mon, 18 Jul 2022 18:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiGRQT4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Jul 2022 12:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiGRQTz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Jul 2022 12:19:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D13225C5D;
        Mon, 18 Jul 2022 09:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658161194; x=1689697194;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=wx+2tefsnxjC6/SPkWBMHDk4yQRZKqq/stF6GFC0Kjs=;
  b=Qw0wdlxfHPJhqrpIIq+yC4fgAyCV8CEGjS/uUKcU1fZlPqysjA4bRY+e
   ad3M8KbFUpxguja9+da7AcdF39F1FOE7Dl+66POl3xP3G3gB8bptbEJ6J
   QDrEuzxUKMC30VXgFBMdUrSeg3MdBvNXJ7ScMwBWXBZSZOFhI8Sfq/HQp
   +F50rVHxDvQmf7jQwClWNr0pCmoaMrtAjVqoof/m7Owvj1oVpS/7QSzae
   iUuW3RNmYa9fJYVH6r4/aQ08rZovqhQObaqd1kHt3RYaVCKW2toeyDPHX
   zjkj89udEpTdcSz9JR52dRj+5yCtFf1Fb5jv9Ej24qaUBPop7WFO1ZHiu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="287004572"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="287004572"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 09:19:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="739527408"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jul 2022 09:19:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 18 Jul 2022 09:19:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Jul 2022 09:19:52 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Mon, 18 Jul 2022 09:19:52 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jane Chu <jane.chu@oracle.com>, "bp@alien8.de" <bp@alien8.de>,
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
Thread-Topic: [PATCH v3] x86/mce: retrieve poison range from hardware
Thread-Index: AQHYmje+5joA3gBAok2TIuU+DOldN62ETyBg
Date:   Mon, 18 Jul 2022 16:19:51 +0000
Message-ID: <41db4a4b17a848798e487a058a2bc237@intel.com>
References: <20220717234805.1084386-1-jane.chu@oracle.com>
In-Reply-To: <20220717234805.1084386-1-jane.chu@oracle.com>
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

+	m.misc =3D (MCI_MISC_ADDR_PHYS << 6) | __ffs64(mem_err->physical_addr_mas=
k);

Do we want to unconditionally trust the sanity of the BIOS provided physica=
l_address_mask?

There's a warning comment on the kernel __ffs64() function:

 * The result is not defined if no bits are set, so check that @word
 * is non-zero before calling this.

Otherwise, this looks like a good idea.

-Tony
