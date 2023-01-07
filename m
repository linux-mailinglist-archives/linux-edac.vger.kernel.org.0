Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F284661178
	for <lists+linux-edac@lfdr.de>; Sat,  7 Jan 2023 21:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjAGUHc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 7 Jan 2023 15:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjAGUHb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 7 Jan 2023 15:07:31 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745221A202;
        Sat,  7 Jan 2023 12:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673122028; bh=tSOH1eP32I97NFu5wkUkSy6bnIbhG1rSWFtljR6XbGI=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=JTfQcGNj2HSwT/wb5ks2krpu1NTXjEYJqwKx+Ebm35ufgoEyfXi+VZ1nlIyHa8WRl
         cOLmxWUF8Au3jFz/MkSO5cG+xfPzlG+cebNVubQ7Y2Lc29282v6j1BOGfhp1Q5GAhZ
         Gpos3jMudQb3mwRNSXlWbJoyqqwO0hWKHmHAiQv4=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat,  7 Jan 2023 21:07:08 +0100 (CET)
X-EA-Auth: d5zWz46cZy/5WK/jzqeRTyyrx9myPtFDSRG5EeUYi+sjDFgNLSGjXq1Iapmnu+b8LAUxrfHXuN6gymrgchtp5UkJZhApPVZP
Date:   Sun, 8 Jan 2023 01:36:59 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] EDAC/altera: Remove redundant error logging
Message-ID: <Y7nQ44/NIRvENktJ@ubun2204.myguest.virtualbox.org>
References: <Y6RIfD/Tv66Oj+kd@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6RIfD/Tv66Oj+kd@qemulion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 22, 2022 at 05:37:24PM +0530, Deepak R Varma wrote:
> A call to platform_get_irq() already prints an error on failure within
> its own implementation. So printing another error based on its return
> value in the caller is redundant and should be removed. The clean up
> also makes if condition block braces unnecessary. Remove that as well.
>
> Issue identified using platform_get_irq.cocci coccinelle semantic patch.
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>

Hello,
Requesting a review and feedback on this patch proposal?

Thank you,
./drv


