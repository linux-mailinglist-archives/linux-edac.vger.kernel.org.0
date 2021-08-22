Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7523F3FCD
	for <lists+linux-edac@lfdr.de>; Sun, 22 Aug 2021 16:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhHVOgz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 22 Aug 2021 10:36:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39498 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234043AbhHVOgy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 22 Aug 2021 10:36:54 -0400
Received: from zn.tnic (p200300ec2f2da100ab464a00f653617a.dip0.t-ipconnect.de [IPv6:2003:ec:2f2d:a100:ab46:4a00:f653:617a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F2BE1EC04F0;
        Sun, 22 Aug 2021 16:36:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629642968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xSosRj+gN6K6/WaqvzcoxmyNJvtEyhrgOWDYMQsCGNo=;
        b=JMU3sneeIbjx/sVlruL4kgrKGsIdwixSJQb56941V6UwFAyS35rn/iiVoZVPy07EWOiCDB
        sJYERF9Yt09gmU1/vgn2UEqp2ryQ1S/j6eyetpP9F3giSwZAJX9pRJwwX4fGgHl3f/g6fG
        glBv9rZOqxxoCg6Ja0zyweOK2wwXs7s=
Date:   Sun, 22 Aug 2021 16:36:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Jue Wang <juew@google.com>, Ding Hui <dinghui@sangfor.com.cn>,
        naoya.horiguchi@nec.com, osalvador@suse.de,
        Youquan Song <youquan.song@intel.com>, huangcun@sangfor.com.cn,
        x86@kernel.org, linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <YSJg/tCG5/YRSZIQ@zn.tnic>
References: <20210706190620.1290391-1-tony.luck@intel.com>
 <20210818002942.1607544-1-tony.luck@intel.com>
 <20210818002942.1607544-2-tony.luck@intel.com>
 <YR/m/8PCmCTbogey@zn.tnic>
 <20210820185945.GA1623421@agluck-desk2.amr.corp.intel.com>
 <YSACMCEoU6FxjDNh@zn.tnic>
 <20210820202346.GA1623796@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820202346.GA1623796@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 20, 2021 at 01:23:46PM -0700, Luck, Tony wrote:
> To recover we need to have some other place to jump to (besides the
> normal extable error return ... which isn't working if we find ourselves
> in this situation) when we hit a fault covered by an extable entry. And
> also know how many machine checks is "normal" before taking the other path.

Hohumm, we're on the same page here.

...

> Bottom line is that I don't think this panic can actually happen unless
> there is some buggy kernel code that retries get_user() or copyin()
> indefinitely.

You know how such statements of "well, this should not really happen in
practice" get disproved by, well, practice. :-)

I guess we'll see anyway what actually happens in practice.

> Probably the same for the two different addresses case ... though I'm
> not 100% confident about that. There could be some ioctl() that peeks
> at two parts of a passed in structure, and the user might pass in a
> structure that spans across a page boundary with both pages poisoned.
> But that would only hit if the driver code ignored the failure of the
> first get_user() and blindly tried the second. So I'd count that as a
> critically bad driver bug.

Right.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
