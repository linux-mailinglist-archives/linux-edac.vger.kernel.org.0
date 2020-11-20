Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF422BB180
	for <lists+linux-edac@lfdr.de>; Fri, 20 Nov 2020 18:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgKTRcZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Nov 2020 12:32:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53824 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgKTRcY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Nov 2020 12:32:24 -0500
Received: from zn.tnic (p200300ec2f11ba0074b4ba83d21d5a9c.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:ba00:74b4:ba83:d21d:5a9c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 745471EC047E;
        Fri, 20 Nov 2020 18:32:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605893543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HZrEZZXLfDY6ZBG3BwoqOBdMQ5Sk++T8MhO/n+cHc/0=;
        b=CaDpxvvdbtKE4hJTkfCdW4efawbiLUdh5aW5+vFj+22Kb9RrAdx48LAx6pSAnvWM4DHtRn
        1L87kHuoF1nrimVsAm116Y+uLf8zBzmIsiY/gnBeq2Drk0KCyKOY+IyhtWwwTv3zSYw41H
        h+Jsey14d0vM43GXXdsf0FLByaIGiXc=
Date:   Fri, 20 Nov 2020 18:32:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Gabriele Paoloni <gabriele.paoloni@intel.com>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, hpa@zytor.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech
Subject: Re: [PATCH 1/4] x86/mce: do not overwrite no_way_out if mce_end()
 fails
Message-ID: <20201120173217.GE712@zn.tnic>
References: <20201118151552.1412-1-gabriele.paoloni@intel.com>
 <20201118151552.1412-2-gabriele.paoloni@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201118151552.1412-2-gabriele.paoloni@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Nov 18, 2020 at 03:15:49PM +0000, Gabriele Paoloni wrote:
> Currently if mce_end() fails no_way_out is set equal to worst.
> worst is the worst severirty that was found in the MCA banks
> associated to the current CPU; however at this point no_way_out
> could be already set by mca_start() by looking at all severities
> of all CPUs that entered the MCE handler.
> if mce_end() fails we first check if no_way_out is already set and
> if so we stick to it, otherwise we use the local worst value
> 
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Also, this very likely wants Cc: stable, I'd say, considering the
severity.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
