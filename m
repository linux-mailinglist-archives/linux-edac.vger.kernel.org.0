Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47C64D932D
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2019 16:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405671AbfJPOAL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Oct 2019 10:00:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45606 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405621AbfJPOAL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 16 Oct 2019 10:00:11 -0400
Received: from zn.tnic (p200300EC2F0939004484EE387460D5B4.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:3900:4484:ee38:7460:d5b4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E94AF1EC0C94;
        Wed, 16 Oct 2019 16:00:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571234410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rfxIM8UotEOA5drHs/In94FZKXAHPY17r+q8zUsKTkA=;
        b=qg2C4rZRmNUBmUMaMbNtLj0hn+Wrf5HZ5loBjTUmRIC7+jAO3PIVmM3GTYYaFuIPOUaxKX
        y9cjQA3Z9w6z3IJlSLgpo0H3aVhGrRYhFG8twBYEe5+AU7UXXziU+hZLlX4qwe5C/1Sagt
        jDVxp8S1qPZnAVHUYur/zPtZW0SJXzA=
Date:   Wed, 16 Oct 2019 16:00:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, bberg@redhat.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, ckellner@redhat.com
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
Message-ID: <20191016140001.GF1138@zn.tnic>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
 <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
 <20191015084833.GD2311@hirez.programming.kicks-ass.net>
 <f481b4ab6dfebbc0637c843e5f1cd4ddfd4bd60b.camel@linux.intel.com>
 <20191016081405.GO2328@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191016081405.GO2328@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 16, 2019 at 10:14:05AM +0200, Peter Zijlstra wrote:
> That all sounds like the printk should be downgraded too, it is not a
> KERN_CRIT warning. It is more a notification that we're getting warm.

Right, and I think we should take Benjamin's patch after all - perhaps
even tag it for stable if that message is annoying people too much - and
Srinivas can do the dynamic thing ontop.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
