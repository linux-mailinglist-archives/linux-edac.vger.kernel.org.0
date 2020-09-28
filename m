Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4AF27AD74
	for <lists+linux-edac@lfdr.de>; Mon, 28 Sep 2020 14:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgI1MFN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Sep 2020 08:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgI1MFM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Sep 2020 08:05:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75610C061755;
        Mon, 28 Sep 2020 05:05:12 -0700 (PDT)
Received: from zn.tnic (p200300ec2f072200e7db2dcfbd154ae2.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:2200:e7db:2dcf:bd15:4ae2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E32D41EC0299;
        Mon, 28 Sep 2020 14:05:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601294710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=44nAg9CdaxdFx7/RfjaA6M4aP2DlupCxNU/SRzXgphU=;
        b=pIs6DGm6aKFUzC7aC4QQBTgP7xfvVRCi7ALKiflT6HG69Xv+j+vJEfSovaqiCL2mXkx9qh
        6iSCNYE1+fW7S9DMEaJtEpSuyIy7yOqsHnADz1iDp69TUIGG68rjGXaRZ7uQkWuuKJIDhf
        3jcoAx1N9TzosGqThGX5HyWrlAwcsxI=
Date:   Mon, 28 Sep 2020 14:05:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, gregkh@linuxfoundation.org, keescook@chromium.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] drivers/edac: convert pci counters to
 counter_atomic32
Message-ID: <20200928120500.GA8151@zn.tnic>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
 <f69320551ff9526b648dd587d15f433c84c13ca3.1601073127.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f69320551ff9526b648dd587d15f433c84c13ca3.1601073127.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 25, 2020 at 05:47:25PM -0600, Shuah Khan wrote:
> counter_atomic* is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
> 
> counter_atomic* variables will wrap around to 0 when it overflows and
> should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> atomic_t variables used for pci counters keep track of pci parity and
> non-parity errors. Convert them to use counter_atomic32.
> 
> Overflow will wrap around and reset the counts as was the case prior to
> the conversion.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  drivers/edac/edac_pci.h       |  5 +++--
>  drivers/edac/edac_pci_sysfs.c | 28 ++++++++++++++--------------
>  2 files changed, 17 insertions(+), 16 deletions(-)

The patches I was Cced - this one and the apei one, look ok to me.

Acked-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
