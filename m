Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDE285E45
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2019 11:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbfHHJaN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Aug 2019 05:30:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38982 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731038AbfHHJaN (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 8 Aug 2019 05:30:13 -0400
Received: from zn.tnic (p200300EC2F0FD70068A09A673825513B.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:d700:68a0:9a67:3825:513b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 69AA41EC0419;
        Thu,  8 Aug 2019 11:30:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565256612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/kQJXHb2/y/WjXp3w/qhdx0nQQQmR2nc4/JBCbPe2s=;
        b=n8L9ov26KIVJ1qvXIvQDTR5OFxSdqggYGzAeKeSmnNfI2OrCPMTi0KaLs3cAYSDkiq9vm2
        TvthkEtoR+RPzFKd37zDQ+WRQm9l7ICq6TCcUa7fv8x9Wti9rZ6aRmeQXRzVRvQaLz8BZb
        vJ7Dyk7tpMNzJ0OMfpDGHcUhHe96Anc=
Date:   Thu, 8 Aug 2019 11:31:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drivers/ras: Don't build debugfs.o if no debugfs
 in config
Message-ID: <20190808093101.GE20745@zn.tnic>
References: <7053.1565218556@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7053.1565218556@turing-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Aug 07, 2019 at 06:55:56PM -0400, Valdis Klētnieks wrote:
> There's no reason to build the debugfs.o if the kernel config doesn't
> even include CONFIG_DEBUG_FS
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> 
> diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
> index ef6777e14d3d..07a5c391cc23 100644
> --- a/drivers/ras/Makefile
> +++ b/drivers/ras/Makefile
> @@ -1,3 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_RAS)	+= ras.o debugfs.o
> +obj-$(CONFIG_RAS)	+= ras.o
> +ifeq ($(CONFIG_DEBUG_FS),y)
> +obj-$(CONFIG_RAS)	+= debugfs.o
> +endif
>  obj-$(CONFIG_RAS_CEC)	+= cec.o

If this is not causing real trouble then I'd prefer to keep it this way
because ras.c is pretty useless without the debugfs functionality.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
