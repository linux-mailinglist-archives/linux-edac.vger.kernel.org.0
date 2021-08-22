Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8166B3F4020
	for <lists+linux-edac@lfdr.de>; Sun, 22 Aug 2021 16:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbhHVOqS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 22 Aug 2021 10:46:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40766 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233009AbhHVOqS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 22 Aug 2021 10:46:18 -0400
Received: from zn.tnic (p200300ec2f2da100ab464a00f653617a.dip0.t-ipconnect.de [IPv6:2003:ec:2f2d:a100:ab46:4a00:f653:617a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D7CB61EC04F0;
        Sun, 22 Aug 2021 16:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629643532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+ko0iIV7PBJ60c1KDZgQc1ufJ27j1ul9I7AoqKxARiY=;
        b=NlPon99KIYT7hKfsgPyRomyJ5Jo8Eibb/z9KFjEyvd88ofgMAPic9jcT48uoK+KXnxUXdW
        zw5+kpv/epGmlnmJQjtsCnh8zcuG3uHoac2gzdRN+t3Ews4sCCwu6BxWHPtIQ1t5qTBRBf
        FD+PMv6vk5Mu2tbZWh5K4p0kl+kAlp0=
Date:   Sun, 22 Aug 2021 16:46:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Jue Wang <juew@google.com>, Ding Hui <dinghui@sangfor.com.cn>,
        naoya.horiguchi@nec.com, osalvador@suse.de,
        Youquan Song <youquan.song@intel.com>, huangcun@sangfor.com.cn,
        x86@kernel.org, linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <YSJjNlTJiBx1v1SS@zn.tnic>
References: <20210706190620.1290391-1-tony.luck@intel.com>
 <20210818002942.1607544-1-tony.luck@intel.com>
 <20210818002942.1607544-2-tony.luck@intel.com>
 <YR/m/8PCmCTbogey@zn.tnic>
 <20210820185945.GA1623421@agluck-desk2.amr.corp.intel.com>
 <YSACMCEoU6FxjDNh@zn.tnic>
 <20210820203356.GA1623896@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820203356.GA1623896@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 20, 2021 at 01:33:56PM -0700, Luck, Tony wrote:
> The new version (thanks to All fixing iov_iter.c) now does
> exactly what POSIX says should happen.  If I have a buffer
> with poison at offset 213, and I do this:
> 
> 	ret = write(fd, buf, 512);
> 
> Then the return from write is 213, and the first 213 bytes
> from the buffer appear in the file, and the file size is
> incremented by 213 (assuming the write started with the lseek
> offset at the original size of the file).

... and the user still gets a SIGBUS so that it gets a chance to handle
the encountered poison? I.e., not retry the write for the remaining 512
- 213 bytes?

If so, do we document that somewhere so that application writers can
know what they should do in such cases?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
