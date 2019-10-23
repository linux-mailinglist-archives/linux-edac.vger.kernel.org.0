Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B47B8E120C
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2019 08:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfJWGYG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Oct 2019 02:24:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36345 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfJWGYG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Oct 2019 02:24:06 -0400
Received: by mail-qk1-f196.google.com with SMTP id y189so18789286qkc.3;
        Tue, 22 Oct 2019 23:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yi1p/5AgQUValFkbegnxonQlGe9ds008uEI8GJ+OXbo=;
        b=AuCfw9OIu+7nH6ya75fRfE9wSSXOEJme4h+b4Jl8lqE3QhpBP0wyip4SbHdD89k+dU
         YXkDowI6+oNJdoRgFSF8ON+KH+nGnv9PS7lTmPjLzsl0n3+c81FqncBaSpb91bkTBQeu
         W7CouiNjm3HxMmcdVYt1E1lY3fcVggMLerrJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yi1p/5AgQUValFkbegnxonQlGe9ds008uEI8GJ+OXbo=;
        b=jQMCkLOGGe61IK461adncOqwHnapsqH5QxTUenhAZ0csTIpUfM8cCqgVri+K9lpzKY
         t8X9aQEroYVOuXUNZnAJ7vYUspbAo8XMRnM2ojF9AUadiljHCGb6S/OK5kDTtJNVn30E
         C5SHhHfO1hJpbfQSn18PbP5qpHkzdOmlfGL0jrvPOYGClT+zs6Qe0KV75yZIJM98C1HK
         2M0DrlDC6RYyS5P3k0gZbnLOG1THXD7A9lDC0/564Vs49+3nVWKdC62VH6vIkKBsTGsr
         WTlY1xoQRO8MI3M9pWD+yXDwBKmLlbf+BxawTXJYesuYbJ+4Dvbb4T8rboINMpqF2Ehi
         hPOw==
X-Gm-Message-State: APjAAAUBoeCu/ae06lfLcWoDv3/Ee096sc8NM7lEUBKK9mbU6GQYqlbH
        +iUXQdNXn+yPlFxxcvucxlugCyHk8HQo+OuGP8o=
X-Google-Smtp-Source: APXvYqzVR5Etz/Es4HiMMf1UU0Ef58kwEksY2/0I7PJeRjGUW1kKtmEKe5E3i1zok0d9FQ5uFZGtdYzcPByiBOb1fvE=
X-Received: by 2002:a37:aa07:: with SMTP id t7mr7032088qke.414.1571811845300;
 Tue, 22 Oct 2019 23:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <baabb9e9-a1b2-3a04-9fb6-aa632de5f722@web.de>
In-Reply-To: <baabb9e9-a1b2-3a04-9fb6-aa632de5f722@web.de>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 23 Oct 2019 06:23:53 +0000
Message-ID: <CACPK8XfUJ5VGpTS3gwxSVZbdWZKPH6PwT2JKGGJ2yzoXYKdtZg@mail.gmail.com>
Subject: Re: [PATCH] EDAC: Aspeed: Use devm_platform_ioremap_resource() in aspeed_probe()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-edac@vger.kernel.org,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Stefan Schaeckeler <sschaeck@cisco.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, 21 Sep 2019 at 16:47, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 21 Sep 2019 18:32:46 +0200
>
> Simplify this function implementation by using a known wrapper function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Joel Stanley <joel@jms.id.au>
