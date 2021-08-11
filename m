Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BA83E8B2C
	for <lists+linux-edac@lfdr.de>; Wed, 11 Aug 2021 09:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbhHKHlD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Aug 2021 03:41:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234043AbhHKHlC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 11 Aug 2021 03:41:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BEBC6056B;
        Wed, 11 Aug 2021 07:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628667639;
        bh=rdqhOz0L1PAh4KXTeSKY4XD8/H+gEn5LQTTMro2BQ9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQVzxGtxi3P/hMjDt7J/0kB2xhblAqToa9zpLvlF8G+Vf83bZyGVBqazQX+UNuqL7
         0Nr4/5GeWK2BB6TfyNUG48RN6NEs/twP/NVKGi+wdis36tHP64IE6qNW4WZJxdhRF7
         QX+oYwtXG362ZK/Rh5crKTcuFKcObaKlFP3l5lwE+f49eN7wJsLEFzl1ZzoBrQAb9Y
         CjoyTSylavwgQXDExA4IJY79Lr3nElg5YusevfuvinucbLmlLyiiD2VmzaeCtt+uDi
         OEQjQ+66vfF0aFHvX8fEAYLiFEdbavEvLltA6xGTpiwuZ2Yfmxti884966gk3bANhO
         1evdzfauj/Xjw==
Date:   Wed, 11 Aug 2021 09:40:34 +0200
From:   Robert Richter <rric@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Len Baker <len.baker@gmx.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drivers/edac/edac_mc: Remove all strcpy() uses
Message-ID: <YRN+8u59lJ6MWsOL@rric.localdomain>
References: <20210807155957.10069-1-len.baker@gmx.com>
 <ff02ffffdc130a772c01ec0edbf8d1e684b0730a.camel@perches.com>
 <20210808112617.GA1927@titan>
 <YRD90L6PMoVbbv+9@rric.localdomain>
 <99448ef29830fda9b19409bc23b0e7513b22f7b7.camel@perches.com>
 <YRKO4An9UkObVGmB@rric.localdomain>
 <b3070c0352e2a5661a1a59d5c5354cc82a1cce1e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3070c0352e2a5661a1a59d5c5354cc82a1cce1e.camel@perches.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 10.08.21 08:02:17, Joe Perches wrote:
> On Tue, 2021-08-10 at 16:36 +0200, Robert Richter wrote:
> > On 09.08.21 10:18:58, Joe Perches wrote:
> > 
> > > strscpy and scnprintf have different return values and it's simpler
> > > and much more common to use scnprintf for appended strings that are
> > > limited to a specific buffer length.
> > 
> > Calculating the bytes written from the return value is a oneliner.
> 
> Not really.
> You still have to test for strscpy's possible return of -E2BIG.

I thought of:

	num = strscpy(p, OTHER_LABEL, len);
	num = num < 0 ? len : num;
	len -= num;
	p += num;

Clearly, this does not look nice, esp. if this is repeated in the
code. That's why I prefer the strlen(p) implementation:

	strscpy(p, OTHER_LABEL, len);
	len -= strlen(p);
	p += strlen(p);

-Robert
