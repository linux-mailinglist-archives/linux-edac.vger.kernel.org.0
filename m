Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACC63F38BF
	for <lists+linux-edac@lfdr.de>; Sat, 21 Aug 2021 06:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhHUEwc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 21 Aug 2021 00:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhHUEwc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 21 Aug 2021 00:52:32 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A825C061575;
        Fri, 20 Aug 2021 21:51:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id m26so10398931pff.3;
        Fri, 20 Aug 2021 21:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k994SCAta50Beg05/fIqKxaoshSEbyIj/0V4L48qJLM=;
        b=MpeK7YtJKvr2ERoawLZlHNq1018vQOoVqXv5bVNHUiTVv13UjLjtUlcxwLWInQhABj
         IEhvadytdpmckzA1oRcNrHTiu8W4s2+4bOTP2mi6X2czPw88mhMewaUYc9lUXumQ+5XK
         i+Ktcb786m3RmQFggH18AT1rmKtivC5P1hlWmK/j8H5DY8AoWA9vX3ZmVJjfWRDgUW/Y
         b7K0fXtmwLXpsPCAfhl9TTTa6GmGZIWONSOkFNRZU/QWCVEWiSDinn2Hq2iUm99rM0Wv
         EvB2eODPII4dnM5giacjbD2fu2iXZM9kQV2naQkiaS2RETlWEq8oCU1CDm70qeefnk+2
         jWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k994SCAta50Beg05/fIqKxaoshSEbyIj/0V4L48qJLM=;
        b=pYLVLg00xDC+KPOL4jW2KMYpWmYI0dJE6n2ys82HXK8aCzaFgGPIxirPmIG0FtL0Qy
         PExlQ1LBgaLlxhmJwA/DigGvGI2g0HBkERUYLlUdNYlwW0hdQFnq5o4uDAhdzUifR23s
         0gI3UOqD4KqbbIwVKG3d8TDsrL5P0xZxk21edweVL9IEtoIcjLdti2korTon8Qrkzsec
         x4IZoA1x5NmINj56JpU20fCIK5QzyC4qM1ma/qTkCnjzO3o+frK6eP4lK+5zSd5q3SZ/
         E6Px6GCNPogV/xxTmuUqrisa1UZjTCU4sh9iLE7FinOLuLjRAeJFghFG12vWHNGTA/pO
         7Q+Q==
X-Gm-Message-State: AOAM5323fRwuP385MWYMpTDT1XGUTVI0qYCjwZ7n0Dmr3tT+XQR/Pso2
        mj29rXzs5a4R2/HYAS3mD0nVaPsm6dTz+7LHkJI=
X-Google-Smtp-Source: ABdhPJxXHXCisTEWRnATao98fGjGi0aL+0tXZQW/EtquJw0bGPu7xYx4hPn6MdEsgguJrhfd+QVaSRqs6dYbMIFzr78=
X-Received: by 2002:a63:c0a:: with SMTP id b10mr21769909pgl.447.1629521512878;
 Fri, 20 Aug 2021 21:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210706190620.1290391-1-tony.luck@intel.com> <20210818002942.1607544-1-tony.luck@intel.com>
 <20210818002942.1607544-2-tony.luck@intel.com> <YR/m/8PCmCTbogey@zn.tnic>
 <20210820185945.GA1623421@agluck-desk2.amr.corp.intel.com>
 <YSACMCEoU6FxjDNh@zn.tnic> <20210820202346.GA1623796@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20210820202346.GA1623796@agluck-desk2.amr.corp.intel.com>
From:   Tony Luck <tony.luck@intel.com>
Date:   Fri, 20 Aug 2021 21:51:41 -0700
Message-ID: <CA+8MBb+M5JoDGONxZuMHZb8VU4DmG=zsv_0JuBhnzn6T=eSKEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user recovery
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jue Wang <juew@google.com>, Ding Hui <dinghui@sangfor.com.cn>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        Youquan Song <youquan.song@intel.com>, huangcun@sangfor.com.cn,
        X86-ML <x86@kernel.org>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 20, 2021 at 1:25 PM Luck, Tony <tony.luck@intel.com> wrote:
> Probably the same for the two different addresses case ... though I'm
> not 100% confident about that. There could be some ioctl() that peeks
> at two parts of a passed in structure, and the user might pass in a
> structure that spans across a page boundary with both pages poisoned.
> But that would only hit if the driver code ignored the failure of the
> first get_user() and blindly tried the second. So I'd count that as a
> critically bad driver bug.

Or maybe driver writers are just evil :-(

for (i = 0; i < len; i++) {
       tx_wait(10);
       get_user(dsp56k_host_interface.data.b[1], bin++);
       get_user(dsp56k_host_interface.data.b[2], bin++);
       get_user(dsp56k_host_interface.data.b[3], bin++);
}

-Tony
