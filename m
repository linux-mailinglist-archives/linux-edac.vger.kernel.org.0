Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C42FAD715C
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2019 10:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfJOIqU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Oct 2019 04:46:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38098 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfJOIqU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 15 Oct 2019 04:46:20 -0400
Received: from zn.tnic (p200300EC2F1578003065FDC9422CE4B3.dip0.t-ipconnect.de [IPv6:2003:ec:2f15:7800:3065:fdc9:422c:e4b3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D5D9A1EC0C7C;
        Tue, 15 Oct 2019 10:46:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571129179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QVfSUDayMGb5LhbHc/yY029RgF5cfEqAjDfth02xUa0=;
        b=X1/9Zj4pWNznRmubFVnNRma29TFVdYsivaAZuTYwXTEkXJl2EQRQWhw45EMRCMMqhQlG2N
        c0MkzWcv2v4S7/ayu1q26bcyw1IF6KgrRXiEb5SMXm4BW+I0fS2+tQPh+gUuRvBA1GLWWh
        5NI3iVK3YXQrg38vdn3AMEFxkLoD9Is=
Date:   Tue, 15 Oct 2019 10:46:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, bberg@redhat.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, ckellner@redhat.com
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
Message-ID: <20191015084614.GB596@zn.tnic>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
 <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
 <20191014213618.GK4715@zn.tnic>
 <3055e340ebaba9f8fb587a11ce3f25cf33919ab3.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3055e340ebaba9f8fb587a11ce3f25cf33919ab3.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 14, 2019 at 03:41:38PM -0700, Srinivas Pandruvada wrote:
> So some users who had issues in their systems can try with this patch.
> We can get rid of this, till it becomes real issue.

We don't add command line parameters which we maybe can get rid of
later.

> The temperature is function of load, time and heat dissipation capacity
> of the system. I have to think more about this to come up with some
> heuristics where we still warning users about real thermal issues.
> Since value is not persistent, then next boot again will start from the
> default.

Yes, and the fact that each machine's temperature is influenced by the
specific *individual* environment and load the machine runs, shows that
you need to adjust this timeout automatically and dynamically.

With the command line parameter you're basically putting the onus on the
user to do that which is just silly. And then she'd need to do it during
runtime too, if the ambient temperature or machine load, etc, changes.

The whole thing is crying "dynamic".

For a simple example, see mce_timer_fn() where we switch to polling
during CMCI storms.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
