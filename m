Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B821A7799
	for <lists+linux-edac@lfdr.de>; Tue, 14 Apr 2020 11:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437754AbgDNJrd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Apr 2020 05:47:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33296 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437751AbgDNJrc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 Apr 2020 05:47:32 -0400
Received: from zn.tnic (p200300EC2F0C1D005C4E4F759039C6AE.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1d00:5c4e:4f75:9039:c6ae])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED52D1EC0CD8;
        Tue, 14 Apr 2020 11:47:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586857650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lHfGyF9osXLBwlBHvpFjg/cBrJLwNrhf6lbtAhTR8+I=;
        b=cUtsx7qwb/HFkqpohuwggklJI6APilMQ5YpXq0i9pQQa5yZweKvBKKUXRsFz8+bZYNh6WV
        kT6TkaTUYHLpgNUHvKPffjcozziTgYNlvOsboJ4jYtFyIH+EBNuNltRuH10ch3z00QfHxg
        ZSJ9dH7MTsJQWX+5PimLtnrIn5SJsjU=
Date:   Tue, 14 Apr 2020 11:47:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jlu@pengutronix.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] EDAC/armada_xp: Fix some log messages
Message-ID: <20200414094725.GA31737@zn.tnic>
References: <20200413041556.3514-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200413041556.3514-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 13, 2020 at 06:15:56AM +0200, Christophe JAILLET wrote:
> Fix some spelling (s/Aramda/Armada/) in 1 log message and in 1 comment.
> 
> While at it, add some trailing '\n' in some other log message.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/edac/armada_xp_edac.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
