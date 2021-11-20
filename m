Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A4E458010
	for <lists+linux-edac@lfdr.de>; Sat, 20 Nov 2021 19:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhKTS7g (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 20 Nov 2021 13:59:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38602 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhKTS7g (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 20 Nov 2021 13:59:36 -0500
Received: from zn.tnic (p200300ec2f227e007756bf95113cdd51.dip0.t-ipconnect.de [IPv6:2003:ec:2f22:7e00:7756:bf95:113c:dd51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F19BC1EC011B;
        Sat, 20 Nov 2021 19:56:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1637434592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YP0WzvRCwJ96px1O4yFE1cWq1zzQA1iUGq1cY3hMda4=;
        b=kLZrHRK4mHdMHZ6u803TItPgWiJr8SHZMCfMhvacigGm8voPyzbZpGLhuN1UdixHsvaEou
        UgJisnvJ36NXpjCh5KvqZWjYcnKqJelo5pjq8FSi+fnVE23XmTkrNMyucSwgN0m4WAD3Ve
        egR+lwj7DKfvFVkeWqv5yHVxql9CCXU=
Date:   Sat, 20 Nov 2021 19:56:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCHv4 1/4] EDAC/synopsys: use the quirk for version instead
 of ddr version
Message-ID: <YZlE2VxkZSUUeFxn@zn.tnic>
References: <20211012190709.1504152-1-dinguyen@kernel.org>
 <778158cf-fbe9-0a65-7982-5372592e5ad2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <778158cf-fbe9-0a65-7982-5372592e5ad2@kernel.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Nov 18, 2021 at 04:43:55PM -0600, Dinh Nguyen wrote:
> Hi Boris,
> 
> can you please take this series through your tree?

Sure, applied.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
