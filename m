Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 945E486432
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2019 16:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfHHOUM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Aug 2019 10:20:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57458 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbfHHOUM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 8 Aug 2019 10:20:12 -0400
Received: from zn.tnic (p200300EC2F0FD700329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:d700:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6AB7A1EC0B07;
        Thu,  8 Aug 2019 16:20:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565274011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZwrkRjBbEgNLieLIZXtCdNxzfE3ArkYH73Az68tJeA=;
        b=ef4To+wzNsiuLlLadr9+VEGlrf6YucqfNH8XoEdkGJgo32j8POlS/0MQfmZcO2ZD4S2op8
        DtrIZKH5dom2INA9JwQGhgjI65/hnNwg1JMj9RZSybQdZSPrtPp46nGDbI6cc2XjrtNomf
        S8PAbgKnZQi3cuSGPSU8GKlbsF+q9ig=
Date:   Thu, 8 Aug 2019 16:20:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drivers/ras: Don't build debugfs.o if no debugfs
 in config
Message-ID: <20190808142055.GF20745@zn.tnic>
References: <7053.1565218556@turing-police>
 <20190808093101.GE20745@zn.tnic>
 <77171.1565269299@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77171.1565269299@turing-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 08, 2019 at 09:01:39AM -0400, Valdis Klētnieks wrote:
> It's needed if somebody applies the patch 2/2 -

It is needed for what?

> and I just got a note from the kbuild test robot saying that
> happened....

Yes, I don't see any issues with 2/2 only applied. I could be missing
some aspect though...

> And if it's that useless, maybe *more* needs to be done to ensure that
> debugfs is enabled if ras is being built - possibly a Kconfig 'select'
> or something....

Or something:

config RAS_CEC
        depends on X86_MCE && MEMORY_FAILURE && DEBUG_FS
						^^^^^^^^
-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
