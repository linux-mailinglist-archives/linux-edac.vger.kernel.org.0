Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4D5825779
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2019 20:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfEUSVE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 21 May 2019 14:21:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54174 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728114AbfEUSVD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 21 May 2019 14:21:03 -0400
Received: from cz.tnic (unknown [165.204.77.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A1C71EC06E5;
        Tue, 21 May 2019 20:21:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1558462862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KHFgAkXxYFk3wROuJ38oqfD4+nr2gZuGxXCjmm/Kcds=;
        b=RIsC4iZIDA4w2oW1aV/cdXmYt+a9pn/rD6DcJVcqFWRUR0fvqCDU/3khIzZefkdGuOPrrP
        UFKwbPRcrtkR0+edGSuEmW4qUeptTdioUPee6LNGP/6PNB6MH4vmbvhSoCncgucJqTOoKB
        uJtNsh5xRcjI2G+Gp/gsmDMNbkibaNw=
Date:   Tue, 21 May 2019 20:21:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yash Shah <yash.shah@sifive.com>, James Morse <james.morse@arm.com>
Cc:     linux-edac@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        James Morse <james.morse@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        mchehab@kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, paulmck@linux.ibm.com
Subject: Re: [PATCH v2] edac: sifive: Add EDAC platform driver for SiFive SoCs
Message-ID: <20190521182132.GB7793@cz.tnic>
References: <1557142026-15949-1-git-send-email-yash.shah@sifive.com>
 <1557142026-15949-2-git-send-email-yash.shah@sifive.com>
 <CAJ2_jOG9Ag0spbh3YCxavUE5XEAUP1pHcgCZ56Nu2u4TqfrzHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ2_jOG9Ag0spbh3YCxavUE5XEAUP1pHcgCZ56Nu2u4TqfrzHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 21, 2019 at 11:00:59AM +0530, Yash Shah wrote:
> The prerequisite patch (sifive_l2_cache driver) has been merged into
> mainline v5.2-rc1
> It should be OK to merge this edac driver now.

James?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
