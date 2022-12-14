Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3469B64D170
	for <lists+linux-edac@lfdr.de>; Wed, 14 Dec 2022 21:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiLNUqa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Dec 2022 15:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLNUq2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 14 Dec 2022 15:46:28 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8710FAED;
        Wed, 14 Dec 2022 12:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671050787; x=1702586787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NGKfvtdkJGB4KsBSmBtkhcCUhI8ssqLY7MUEO8rIdbQ=;
  b=Qi0+Qw2pnxtrQSLKtLxLA2dbEXQue28bL52D90wCOOnzNunSIckyNE1/
   QkLQrKHOTD5S8RaB4ij9jpjD3z6PXy7nyP4kpso7IpF4vy/d7UQXNFnd2
   VEGBdu9lmqz0Y7qv7IgCG6Wu/gaiPdBP7N1dQygLlB7UyI7f/72KfllPI
   IG+puCzvBLDvwwYWdAI6p/6zpwWJjt5A4WJnide3VTtATqZRRCNjInq3y
   GmHgqnT05d2P7hedWNq5fdBVEs9VKKuGXHMyu0GQiDkoZPJfOhrN6iz8i
   lUzLcimzLJsOnr5odxOgVl3HigkIZ3IfEap0oxs9wPs4pmiDSxODx6b4P
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="345588316"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="345588316"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 12:46:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="642667942"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="642667942"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 14 Dec 2022 12:46:25 -0800
Date:   Wed, 14 Dec 2022 12:54:38 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     yang.yang29@zte.com.cn
Cc:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] x86/mce/dev-mcelog: use strscpy() to instead
 of strncpy()
Message-ID: <20221214205438.GB15255@ranerica-svr.sc.intel.com>
References: <202212031419324523731@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212031419324523731@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Dec 03, 2022 at 02:19:32PM +0800, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL terminated strings.

It should read "NULL-terminated strings".

Thanks and BR,
Ricardo
