Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5B12E03C
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 16:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfE2OzB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 10:55:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50834 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfE2OzA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 10:55:00 -0400
Received: from cz.tnic (unknown [207.225.69.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D01DB1EC01AD;
        Wed, 29 May 2019 16:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1559141699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vEYbKqClcQsPDtUPPoQEYm3CxV8887wcrSdsYDhcWaQ=;
        b=kbEKr11SEILkfdZ6XaMFVswCRxLz/lhovyPg7TT6Ov52/679LP6oB5x3UnTFfS/RimjhMT
        La8PCP4x9DX0I6CrwWZzFmAGzd5jLvxcmrkOuchjdXc2l6hJSguSi+jmEpFAJfCShrqlQh
        b2w76nGKhYCaSUo7/usepcrZkd7zZUw=
Date:   Wed, 29 May 2019 16:54:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/21] EDAC, mc, ghes: Fixes and updates to improve
 memory error reporting
Message-ID: <20190529145452.GD2951@cz.tnic>
References: <20190529084344.28562-1-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190529084344.28562-1-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 29, 2019 at 08:44:01AM +0000, Robert Richter wrote:
> Patch #1: Repost of an already accepted patch sent to the ml. Adding
> it here for completeness as I did not find it in a repository yet.

Try mainline:

29a0c843973b ("EDAC/mc: Fix edac_mc_find() in case no device is found")

:-)

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
