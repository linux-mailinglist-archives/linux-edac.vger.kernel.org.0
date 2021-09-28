Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAA641B46F
	for <lists+linux-edac@lfdr.de>; Tue, 28 Sep 2021 18:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhI1QxS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Sep 2021 12:53:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48376 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241894AbhI1QxS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 28 Sep 2021 12:53:18 -0400
Received: from zn.tnic (p200300ec2f13b2007486680f97542e69.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:b200:7486:680f:9754:2e69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6BEB71EC0749;
        Tue, 28 Sep 2021 18:51:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632847897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OB7Pm/rdPr9mQxr5gn6UCKr6jREgLCqOq5UsWUEca6U=;
        b=ToPP3aNf9nHZukWq3WstWjw/ocRJ1G36r69Pfrrn6Xp4bVfd0iH1jdZ9yhkKXaMNhpZff2
        Q/IPHOJjBSUsZ2gHtcRgBNXE8+/cOYgag0NVBOMFn8aK3SgNoQvObzR6vNAsFCg0qzWgnD
        iWwbbweCzVJVy26JkWXob++lY0maF2w=
Date:   Tue, 28 Sep 2021 18:51:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Talel Shenhar <talel@amazon.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/al-mc-edac: Make use of the helper function
 devm_add_action_or_reset()
Message-ID: <YVNIEAuis8D1UQDt@zn.tnic>
References: <20210922125924.321-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210922125924.321-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 22, 2021 at 08:59:23PM +0800, Cai Huoqing wrote:
> The helper function devm_add_action_or_reset() will internally
> call devm_add_action(), and if devm_add_action() fails then it will
> execute the action mentioned and return the error code. So
> use devm_add_action_or_reset() instead of devm_add_action()
> to simplify the error handling, reduce the code.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/edac/al_mc_edac.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
