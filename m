Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9765264D291
	for <lists+linux-edac@lfdr.de>; Wed, 14 Dec 2022 23:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiLNWq3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Dec 2022 17:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiLNWq0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 14 Dec 2022 17:46:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1766A36D41;
        Wed, 14 Dec 2022 14:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671057974; x=1702593974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=blKr85VDRrsCdVGyZu/nawGaU6nyURJeIMV9D/SQEk8=;
  b=ljKxj2xMXxxXZtrVxPPbL0rMNYoSiZEYiMDG/BgkmAadpo1AGnls5e8K
   aB3enc97N/DssvMlyljqFM1IZgDr//EEdoTGZQB6v/R2aeEDbahNHzLkq
   hvWsU3z2xuOhMtl/+kmE52jR9U5h/OSplMsNu9mhoQhyFuAzIRsYsnWBB
   RSfuH8QRFdCHrnkWiY1YHDlfUQJ4eNduH/mlz7S1bckLQNh4qRTzgBm8A
   tBpuCEryzOZvyjv+gRT+EU/ZqbO3vxqFjQ3Vwg9lRqFH2Wal8iAGt++FT
   aare7Dy4izmSXuQu/n+EJchzM4QIQUQpdt/VcNDPsH7Ew83GKp3bagHFN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="318577454"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="318577454"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 14:45:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="712646318"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="712646318"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 14 Dec 2022 14:45:48 -0800
Date:   Wed, 14 Dec 2022 14:54:02 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "yang.yang29@zte.com.cn" <yang.yang29@zte.com.cn>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xu.panda@zte.com.cn" <xu.panda@zte.com.cn>
Subject: Re: [PATCH linux-next] x86/mce/dev-mcelog: use strscpy() to instead
 of strncpy()
Message-ID: <20221214225402.GA16409@ranerica-svr.sc.intel.com>
References: <202212031419324523731@zte.com.cn>
 <20221214205438.GB15255@ranerica-svr.sc.intel.com>
 <SJ1PR11MB60831C20F1A68163E04D742CFCE09@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ1PR11MB60831C20F1A68163E04D742CFCE09@SJ1PR11MB6083.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Dec 14, 2022 at 09:29:59PM +0000, Luck, Tony wrote:
> >> The implementation of strscpy() is more robust and safer.
> >> That's now the recommended way to copy NUL terminated strings.
> >
> > It should read "NULL-terminated strings".
> 
> Both "NUL-terminated" and "NULL-terminated" seem to be used in the kernel
> source and commit comments.  NULL is ahead 124:45 in the source, but it
> is closer in the commit logs where the ratio is 129:76.
> 
> Single "L" NUL seems technically more accurate as the string terminator is
> an ascii NUL character. From man 5 ascii the character name is NUL (though
> the description says "null" to muddy the waters)
> 
>        Oct   Dec   Hex   Char
>        ───────────────────────────────────────────
>        000   0     00    NUL '\0' (null character)

Thanks for the analysis Tony. Indeed, I agree that "NUL-terminated" is
more accurate.

Thanks and BR,
Ricardo
