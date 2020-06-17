Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C998A1FCFA2
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jun 2020 16:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgFQOdo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 Jun 2020 10:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQOdo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 Jun 2020 10:33:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A36C06174E;
        Wed, 17 Jun 2020 07:33:44 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s88so1144047pjb.5;
        Wed, 17 Jun 2020 07:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A7+787E4TJUG9/bCUJgW+ej33fZ4Z2tVDSzeCsYPOrY=;
        b=kRUTMws7Q0VVgVgY/TAXGsl/Y4szr0tnZ3vP92473/zUuwn96UJlHq5zmc1TrccEuL
         haONzpFTJ/tSz9i9ZcMtGQ6fPT2VGgMiX5yx1Mx2cRaVI+OUfZgfOMtF/grQjAHno+QF
         0Wkava6HXcZZzTkrjArQp6VgKNMP9fsifQwpHKW6KHOsSJ897CwtEibKaTv2TTIZhqA2
         ZGP9gPjtZwrILzZMlvK9QKu4Bt/4pe7ksx5+oGJvRASZNg7oKo0aZIroOo4W/je21FIT
         TTVKjTs87RQfvlSOSUF4KJgjhBsUoC2P1R87kN6GrAGqF0SdHOQetcVQQ8KrVNEDOW2c
         ozfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=A7+787E4TJUG9/bCUJgW+ej33fZ4Z2tVDSzeCsYPOrY=;
        b=akpkmIbZVnGLG8FvG0/BNuFZg5MByzpdBDuOii27Ye80/fpvvmNAL+e1OHrRKXONUv
         ocuJODqA4uUdwcBtgcGRt2Nb4daHiUXJMWch8idBAQoxfE1PGFCfzoi1PDRBA1CkIWvj
         Mh1F03uHyhi+x4ythoWoIf3JMAcfMigm9amWQ2yelrVXs0GlBOHPr2nLPkeipEUSJEpM
         4vmJnpGWneFJjnTyEON7DNgrq4bWC2zoR7LSMb+KcKGaCpqWvuXq436wmo4boo8ho4TL
         sCQirYuvF5SaVJ06HZc00bXjGXSqJCJpsitfwFvJuyrzdK8JSRqtAEw79jc240Nzpd77
         eewQ==
X-Gm-Message-State: AOAM530xy6r18WDR5a1PoHYl/ucIGB9XyzE6TasHBYH0wNP6aU7QS3BY
        85t1ETy5pc+l/mhFWN8wA7Y=
X-Google-Smtp-Source: ABdhPJy/Zf8bsf33U9+WE6cB+Uw6CQw+yQFwsmKugqosMVhjoOEOaCsPOdUOOpuZRgWDunmN8ix7Tw==
X-Received: by 2002:a17:902:7004:: with SMTP id y4mr2055981plk.83.1592404424022;
        Wed, 17 Jun 2020 07:33:44 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w12sm135347pfn.68.2020.06.17.07.33.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jun 2020 07:33:43 -0700 (PDT)
Date:   Wed, 17 Jun 2020 07:33:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jacky Hu <hengqing.hu@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        yazen.ghannam@amd.com, bp@alien8.de, clemens@ladisch.de
Subject: Re: [PATCH] hwmon: (k10temp) Add AMD family 17h model 60h probe
Message-ID: <20200617143342.GD93431@roeck-us.net>
References: <20200616180940.GN13515@zn.tnic>
 <20200617013255.391975-1-hengqing.hu@gmail.com>
 <20200617034028.GA1614@roeck-us.net>
 <20200617071927.GA398128@i716>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617071927.GA398128@i716>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 17, 2020 at 03:19:27PM +0800, Jacky Hu wrote:
> Hi Guenter,
> 
> By increasing the regs count from 32 to 256 and looking into the output of `cat /sys/kernel/debug/k10temp-0000\:00\:18.3/svi`
> There is some data from 0x05a300 - 0x05a330
> Do you have any idea how we can guess the offset for this model?
> 

For other chips, the upper 16 bits of the register reported the voltage
and the lower 16 bit reported the current. It might possibly be that the
data is now split into multiple registers, but that is impossible to
determine without datasheet and/or additional information. So, sorry,
no, I have no idea. We'll have to wait for someone to reverse engineer
it.

Can you send the contents of the "thm" file ? Maybe we can at least
find the new location of the ccd temperature registers.

Guenter
