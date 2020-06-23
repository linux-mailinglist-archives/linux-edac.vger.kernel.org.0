Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D315204DB2
	for <lists+linux-edac@lfdr.de>; Tue, 23 Jun 2020 11:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbgFWJSU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Jun 2020 05:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731735AbgFWJST (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Jun 2020 05:18:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0361C061573
        for <linux-edac@vger.kernel.org>; Tue, 23 Jun 2020 02:18:19 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d47000df57aa2909cb634.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4700:df5:7aa2:909c:b634])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E323D1EC0299;
        Tue, 23 Jun 2020 11:18:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592903897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=80ut5BScFFLCRQHCBkAUK12GepcJB3BnwXiaPGsJQ0I=;
        b=M46fnF/dT8GppjyrbEQhVGk/iDGmnR1/tNjciutCo38soMCrpOJy2ykN+fUnAsgoyGmv8W
        yKXlnJFXBnHnkM9nfrigz/gWxMmoDSjy5wa2vZ5bMW4dYwECMtn7CmoHtue+Ix8g5wn5/a
        8W3xLxguS6HQSDyy1jNXq0ZVmojJFxM=
Date:   Tue, 23 Jun 2020 11:18:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Anders Andersson <pipatron@gmail.com>
Cc:     linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: Read back the scrub rate PCI register on F15h
Message-ID: <20200623091809.GA32590@zn.tnic>
References: <CAKkunMbNWppx_i6xSdDHLseA2QQmGJqj_crY=NF-GZML5np4Vw@mail.gmail.com>
 <20200618175646.GD27951@zn.tnic>
 <20200618184041.GE27951@zn.tnic>
 <20200622151305.GD32200@zn.tnic>
 <CAKkunMZLhou+T1xdOBi717Jk3JrREd5AHLKk3vK8rqSrvFuAew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKkunMZLhou+T1xdOBi717Jk3JrREd5AHLKk3vK8rqSrvFuAew@mail.gmail.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 23, 2020 at 03:41:35AM +0200, Anders Andersson wrote:
> Ok, finally tested the patch on my machine, and (no surprise)
> everything now works as expected, thanks!

Thanks for testing, patch will appear upstream and in stable soon.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
