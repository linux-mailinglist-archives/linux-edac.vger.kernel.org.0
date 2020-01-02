Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04AAD12E50D
	for <lists+linux-edac@lfdr.de>; Thu,  2 Jan 2020 11:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgABKt1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Jan 2020 05:49:27 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42388 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgABKt1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 2 Jan 2020 05:49:27 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so56502637otd.9;
        Thu, 02 Jan 2020 02:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y5AmgH9Xq3GHzR9brV2WTaiaDsJrcgQPsQ1iAp+0h/A=;
        b=hSsheaZ99+A7jbL8KZImDfGlWdMecIybZ2NAH1ay67yMu4QHI56wRWS7qb/+aVChSL
         TuEqcQET+9rHsSYUe3dujbXy+CoyF/5uEw39+KM7RUr2FcbxERiYH+/LcunXDTwyPkn1
         eXDYPSnLcHJpQrBRxo1CoYrDGX7KUCYtbkdA00dluIWhtXYnojAehrTvBxFrXuqfuB5V
         V3vi+c5t8HFRvT/LMxNQJuNt9Spp7zxAKQUgVhsFFskJgaxGIWPgkxOAora/ejx/zFKV
         im0c//HNLgnsIHRvERId/XgBT1vAHwKxLThd3R2h/zmc+IOt60CK2++DYjc8Yp6OgAW8
         NxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5AmgH9Xq3GHzR9brV2WTaiaDsJrcgQPsQ1iAp+0h/A=;
        b=q6Oxe43UROH0WJpb3rNmnwEqdKBUvGefnSCSqfPXy4HnyzAAQQV+hib2r1Ov6KvGLH
         PP/UHye0pjTX8ak18fcex2P5f4L+Gn8aXkxKn3xfaxc0fzDJTaX5DoXVRY/ANVsCGgLu
         VXW4adahe4FSehP7Ra3NLwvkkiNA70cQcNYlEZ28kJ4Td6giH25ZuCDeRXCsVTnYGqxQ
         MsMnsoHRTLjg2aFIrdmufygaukc9uFRoERAUDl0cumFntmkMdK3tQ6igtFTapGAqjFMQ
         FG3+au32USaBpgEejl0F/ahhpdj5D6RctmgiJoNClVZHIempVlS29+k5PGg0qu9CVF/x
         Rfkw==
X-Gm-Message-State: APjAAAXp+q3j+CnKjlrKtQLL4rfyTbNOQBX2mJqun5d6E7mS3+kV6Mts
        3ZxyVV/dCoy09BxGpCUng/HhMNfuzp+L3ZpTZac=
X-Google-Smtp-Source: APXvYqyXuuDNhlVCXqPOP1tPGkkx/cVbRt8Bxgn06HICHCyY6q+ib4whaRbdCbCr1n0PzXMycJUDZz5SnyncBoW6bvM=
X-Received: by 2002:a05:6830:4ca:: with SMTP id s10mr52393190otd.268.1577962165967;
 Thu, 02 Jan 2020 02:49:25 -0800 (PST)
MIME-Version: 1.0
References: <1576652618-27017-1-git-send-email-bupadhaya@marvell.com>
In-Reply-To: <1576652618-27017-1-git-send-email-bupadhaya@marvell.com>
From:   Bhaskar Upadhaya <bhaskar.upadhaya.linux@gmail.com>
Date:   Thu, 2 Jan 2020 16:19:15 +0530
Message-ID: <CAEYJA6qm0tpkOd81L6mG9OhtB4FFmTOMN-SfM2FjbibCvWkMHQ@mail.gmail.com>
Subject: Re: [RFC PATCH] apei/ghes: fix ghes_poll_func by registering in
 non-deferrable mode
To:     Bhaskar Upadhaya <bupadhaya@marvell.com>, rafael@kernel.org,
        lenb@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, gkulkarni@marvell.com,
        rrichter@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Rafael, Len
  Hope you get time to look into this patch.
Regards
--Bhaskar

On Wed, Dec 18, 2019 at 12:34 PM Bhaskar Upadhaya <bupadhaya@marvell.com> wrote:
>
> Currently Linux register ghes_poll_func with TIMER_DEFERRABLE flag,
> because of which it is serviced when the CPU eventually wakes up with a
> subsequent non-deferrable timer and not at the configured polling interval.
>
> For polling mode, the polling interval configured by firmware should not
> be exceeded as per ACPI_6_3 spec[refer Table 18-394], So Timer need to
> be configured in non-deferrable mode by removing TIMER_DEFERRABLE flag.
> With NO_HZ enabled and timer callback being configured in non-deferrable
> mode, timer callback will get called exactly after polling interval.
>
> Impact of removing TIMER_DEFFERABLE flag
> - With NO_HZ enabled, additional timer ticks and unnecessary wakeups of
>  the cpu happens exactly after polling interval.
>
> - If polling interval is too small than polling function will be called
>  too frequently which may stall the cpu.
>
> Signed-off-by: Bhaskar Upadhaya <bupadhaya@marvell.com>
> ---
>  drivers/acpi/apei/ghes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 777f6f7122b4..c8f9230f69fb 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1181,7 +1181,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
>
>         switch (generic->notify.type) {
>         case ACPI_HEST_NOTIFY_POLLED:
> -               timer_setup(&ghes->timer, ghes_poll_func, TIMER_DEFERRABLE);
> +               timer_setup(&ghes->timer, ghes_poll_func, 0);
>                 ghes_add_timer(ghes);
>                 break;
>         case ACPI_HEST_NOTIFY_EXTERNAL:
> --
> 2.17.1
>
