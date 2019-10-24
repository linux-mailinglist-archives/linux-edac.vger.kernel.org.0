Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A93E3F7F
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2019 00:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbfJXWqS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Oct 2019 18:46:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34626 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfJXWqS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 24 Oct 2019 18:46:18 -0400
Received: by mail-oi1-f194.google.com with SMTP id 83so100213oii.1;
        Thu, 24 Oct 2019 15:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+iYm9hhGYVouEXtUjL2jRjX69VZ0OpuZNE9dMxN82Z0=;
        b=HBFcjauFHWD3zdedd51jKTRGRHOvBnX8iewu1QPSfrzc7DJgoRkvFiVXeeDDT5xbH/
         G2tEv4FQ0GwQQSi9sETf3w4bnGTTt+3TS8smzRIcHvHAn9h3VfooveP2SHTtzZbE7t5I
         gp7ZwZxs2yo58aew4KNupt9WzTmXK9PR2aAR6ghTwHWIwPc6f9NV1F3dYBVrdKCMQ42K
         sq/FyfpFuGrw4tmj11YdfWwEb+59cBVqPoiuqK76Ya8K+QsQjQA2FtN5mbVJD9phKalE
         45fy2MbqbUvaro42uoS0ITe4KR21mgolJJz5pXDUXfhCqb85Eqi1nVqLfjVDnfixwM7Y
         u22g==
X-Gm-Message-State: APjAAAVjjeDs24OFOd/Ms3t8JZonb9pVPAzpfVEqDrhg/J+nGo1MdKk5
        /uKz+eXNEHT9+hxzThoGVw==
X-Google-Smtp-Source: APXvYqzcDd0KbW6kYrDpZgeQ/wDd33vezmU0H1O01I/KLIHLbY1ahwlYjQAXsL8Us3QXUBAfS0x2OA==
X-Received: by 2002:a05:6808:b21:: with SMTP id t1mr409766oij.16.1571957177299;
        Thu, 24 Oct 2019 15:46:17 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u130sm26783oib.56.2019.10.24.15.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 15:46:16 -0700 (PDT)
Date:   Thu, 24 Oct 2019 17:46:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     mark.rutland@arm.com, bp@alien8.de, mchehab@kernel.org,
        james.morse@arm.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, hhhawa@amazon.com, ronenk@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, amirkl@amazon.com,
        barakw@amazon.com
Subject: Re: [PATCH v5 1/2] dt-bindings: edac: al-mc-edac: Amazon's Annapurna
 Labs Memory Controller EDAC
Message-ID: <20191024224615.GA3106@bogus>
References: <1571911407-29379-1-git-send-email-talel@amazon.com>
 <1571911407-29379-2-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571911407-29379-2-git-send-email-talel@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 24, 2019 at 01:03:26PM +0300, Talel Shenhar wrote:
> Document Amazon's Annapurna Labs Memory Controller EDAC SoC binding.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> ---
>  .../bindings/edac/amazon,al-mc-edac.yaml           | 52 ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
