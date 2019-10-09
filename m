Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62361D1783
	for <lists+linux-edac@lfdr.de>; Wed,  9 Oct 2019 20:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfJISXA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Oct 2019 14:23:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47614 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731072AbfJISXA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 9 Oct 2019 14:23:00 -0400
Received: from zn.tnic (p200300EC2F0C2000CC8F9AE7D5DA1569.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2000:cc8f:9ae7:d5da:1569])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0465D1EC0985;
        Wed,  9 Oct 2019 20:22:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570645375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4/5FsRTjMNHO5BfmggN6zQ+7kKutt7bjJppYyHeXwMk=;
        b=USilAOzMo/+5vaLFuHArKLhkhTkQ5Usa0uZUNvbpvn/Y2GEicZCMviAwBp1+8mGzSjQ05C
        z5gKYLlNX7esT0IUuyREhzKV4H4UqrBXx7HA5rZ5L/0IdTapG8kAWtrAxvyjIqLKXCFVDl
        GBprpvaiXzE/hOW9ETL21Otts5m7jU0=
Date:   Wed, 9 Oct 2019 20:22:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joe Perches <joe@perches.com>
Cc:     Benjamin Berg <bberg@redhat.com>, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Lower throttling MCE messages to warnings
Message-ID: <20191009182246.GL10395@zn.tnic>
References: <20191009155424.249277-1-bberg@redhat.com>
 <20191009175608.GK10395@zn.tnic>
 <1dfc2bf57335b7eb9f130cc791db76655fb5b8f4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1dfc2bf57335b7eb9f130cc791db76655fb5b8f4.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 09, 2019 at 11:05:37AM -0700, Joe Perches wrote:
> Perhaps this should be
> 
> 	pr_warn_ratelimited(...)
> 
> as the temperature changes can be relatively quick.

There's already ratelimiting machinery a bit above in the same function.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
