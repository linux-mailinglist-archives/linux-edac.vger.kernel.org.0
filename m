Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1657E1FF9B3
	for <lists+linux-edac@lfdr.de>; Thu, 18 Jun 2020 18:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbgFRQuY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 18 Jun 2020 12:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbgFRQuW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 18 Jun 2020 12:50:22 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE99C06174E
        for <linux-edac@vger.kernel.org>; Thu, 18 Jun 2020 09:50:22 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c75so6424494ila.8
        for <linux-edac@vger.kernel.org>; Thu, 18 Jun 2020 09:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=eihDiEoZQxPyT7gze3G/OpngwSDSpOI/LqfVWohJ65o=;
        b=STCn+dK0hqdK3kuGQ+x64hvokU+TlKxKwZJoWvHGhlYjU2rvHUI6y3EMNxLW/bRGnu
         yLAJR8TKgeGo3oZvUkUtbCb9Tjo1dYMLMCZ8t7ExNfr7GnLLVGoGgeOFXvGNCOnyQ+G0
         QGNIxbXoDA0C0tOneUtJFAvlnVI+Cc4qjZ5wqt58DA3Wy+an6FmbYluCM7sM3WxgDgdy
         IiMeFW0zVuBan++HKkWDUMVKA/w/XfkSwUIU0Ovy3APh2ZN1A+jPQwOLuaTWy44QSmXJ
         kFVtyAZHYCaKCeygWGsWvz3/h1SvVpgaldxKvrWTiwsma4jl4p7phpwdSwxkltrf+tdG
         thLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eihDiEoZQxPyT7gze3G/OpngwSDSpOI/LqfVWohJ65o=;
        b=dtOPUMRPScpKK5pvpLXVHb6SMqBTQB1LHBqKEE2hZGO6mjSMxkoYR+J4XCm7OWBlm/
         QRxqAadB2NJgIdNzCLrThJ4oTwcayCrrsaj+aknCyKIcLnTi0Ux8hmOAag25nsneqJyF
         aZe6ssOvdChHuqBDUlQmhxwP4lQL4MGk3mfZvsUSQiD/mBSpppXm2qFdW3M0CqfyY25S
         1oltDMPrK11JSPelnFy1T+bcX2Zao814kHc4rS1fgRawfuzgkt07dolV0UisYV/LPD5I
         YGWR4ClPcMQs+SAZ4EOeS30wK8fRGUf3coLtQowLvjFh5xMsHdTbVII7h0J9NfRDs/W1
         C2NQ==
X-Gm-Message-State: AOAM531PjOengyw7TO6bpFf7u9cBu5EKCTI3PpNEjwRXrRxdtcjqawwb
        ogKsL4dRhZoe2H9ktyGvu8Dp+bQRqoSBRcvxGWMvAf40hSs=
X-Google-Smtp-Source: ABdhPJxcg0hmNn5Br8lN6m0ehlUaPBWlAoIXjw5bZazX13IrZv1BNWWZs9L6ZMgAT8LLHUI3CVRwEQOeQvSgP45uSIg=
X-Received: by 2002:a92:de0d:: with SMTP id x13mr5173120ilm.256.1592499021477;
 Thu, 18 Jun 2020 09:50:21 -0700 (PDT)
MIME-Version: 1.0
From:   Anders Andersson <pipatron@gmail.com>
Date:   Thu, 18 Jun 2020 18:49:45 +0200
Message-ID: <CAKkunMbNWppx_i6xSdDHLseA2QQmGJqj_crY=NF-GZML5np4Vw@mail.gmail.com>
Subject: User question about memory scrubbing
To:     linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi! I realize that this is more of a developer-to-developer list, but
I'm a hobbyist who recently bought my first system with ECC RAM
(Opteron 6386 SE) and I can't get memory scrubbing to work. It's hard
to find people who know anything about it.

Preliminary research led me to the EDAC documentation on
https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-devices-edac
and in particular the "sdram_scrub_rate" file, but had no luck
manipulating it.

Before I'm getting too lost: Is that the right way to configure it?

I have amd64_edac_mod and edac_mce_amd loaded. I briefly looked at
amd64_edac.c and it appears to have the necessary code and matches the
documentation from AMD so there's something I'm not doing right. I did
post a more elaborate question on
https://unix.stackexchange.com/questions/593060/how-do-i-enable-and-verify-ecc-ram-scrubbing-in-linux
but I'm afraid it's too technical for most users (too technical for me
too apparently!)

Hints and pointers welcome,
Anders
