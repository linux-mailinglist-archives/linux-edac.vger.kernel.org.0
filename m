Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B666E162A56
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2020 17:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgBRQXC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Feb 2020 11:23:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51210 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgBRQXB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 18 Feb 2020 11:23:01 -0500
Received: from zn.tnic (p200300EC2F0C1F0014C3F76BBACA8B76.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1f00:14c3:f76b:baca:8b76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89D0D1EC0273;
        Tue, 18 Feb 2020 17:23:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582042980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mWXkj9EqAVkCheQgZBQ+7aSsSl+evXPSmLLYsoTW9EM=;
        b=cnyHWtDHc6k95iulQ5Qi+KEPvIcIIK89kDuvyw3e6LABdb5mgyYjOCq/gUXP3IholrCP2R
        JOcUBNVnYudtXkxKdiORcSFB8ds76+Fjw0yB1yv3OC/XiqDDdwQfOFBAavDyCA19xyKkhG
        37meLu8gQzX+Es4aPXsPq5VSi7ZrhtM=
Date:   Tue, 18 Feb 2020 17:23:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Krupp <centos@akr.yagii.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v2] x86/mce: Do not log spurious corrected mce errors
Message-ID: <20200218162300.GH14449@zn.tnic>
References: <20200217130659.15895-1-prarit@redhat.com>
 <20200218161319.GG14449@zn.tnic>
 <e1bf1a0e-db70-906f-d09c-90cc2eef28dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1bf1a0e-db70-906f-d09c-90cc2eef28dc@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Feb 18, 2020 at 11:17:34AM -0500, Prarit Bhargava wrote:
> That's weird.  I just re-compiled it on my system without any issue.  Can I have
> your .config to double check my compile?  I'm using the standard fedora config FWIW.

Just disable CONFIG_X86_MCE_INTEL

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
