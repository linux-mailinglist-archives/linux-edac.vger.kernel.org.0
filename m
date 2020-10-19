Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BB9292E88
	for <lists+linux-edac@lfdr.de>; Mon, 19 Oct 2020 21:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgJSTfd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Oct 2020 15:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27911 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730021AbgJSTfd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 19 Oct 2020 15:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603136132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=C9AZJInHSA4bqiVYuqisAmQR3f3OqCj1KITHHKH76j8=;
        b=ZD1+RqJE761W5rFRCs5Z7N4RTjlgCYANi7+q0SGit/DQdh+81fhVm91jEahB1Q1jXrqIvA
        JEtIQPynQAVxqqSq+B7BAZcrGF7qkx4OSlQhep04oEobID2q8P6+TdKXt3iWZAxhC6aZiz
        TzrPZLl0s78kbV6+kyFt4/ptuINXyO0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-sG8UvkRMNWySMD9I5F04lg-1; Mon, 19 Oct 2020 15:35:30 -0400
X-MC-Unique: sG8UvkRMNWySMD9I5F04lg-1
Received: by mail-qk1-f200.google.com with SMTP id y8so480158qki.12
        for <linux-edac@vger.kernel.org>; Mon, 19 Oct 2020 12:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C9AZJInHSA4bqiVYuqisAmQR3f3OqCj1KITHHKH76j8=;
        b=FaPeOtfheIfHLtor/TWNGccrpWx0bMUcwF5aQWPaCZ5Ae3EF28VhUq8UUHlnfWLl8N
         t7ljkk0AcRvPO0LqK0OeI0EJGbmrizOJ8iGlDJ/vQlVP9EWlvgF266OC5wLyxWF0eZ4x
         oY1bvqYuxXNlRC20+LanlaANsfEYT4dgAWEBdzYie7vfgQRbkR2ThEuHDXGtFR8/ud2n
         UGvdDNrjtdD8pUyS9x1ddswzF7RhMoNupvX9fe7XVxpAx0IrZ17cBLMBJQv2DVQ/gHda
         1zxjaWaZLuO8tEjGSIQle9k4w30lESti3XJG0uyvF4J7DtzdL+gwm1KIm3EXSqYeb0R5
         NnGw==
X-Gm-Message-State: AOAM533LRYz4YzAgQtdXlIM6HROQD63q4T1Z0cYIJr+2KJeT+f8StEg6
        /MmzOkGq6VOjt9eqrldkSdHSSXI7C2bN0bqO2GAO/22MD88uPEj1XhW+5uAmpaVgdGRDPJY1KLA
        hhuwiCjtthjzPxzu3eOFVOg==
X-Received: by 2002:ac8:59d4:: with SMTP id f20mr978042qtf.327.1603136129775;
        Mon, 19 Oct 2020 12:35:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNn25tOM18TKKphRcF7Bg5son2KFp4L4PtW6Ts6kD/aZlr1L+H762Br156VUgjamQ6Rc0lEA==
X-Received: by 2002:ac8:59d4:: with SMTP id f20mr978021qtf.327.1603136129574;
        Mon, 19 Oct 2020 12:35:29 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p5sm363005qtu.13.2020.10.19.12.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:35:29 -0700 (PDT)
From:   trix@redhat.com
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] edac: amd64_edac: remove unneeded break
Date:   Mon, 19 Oct 2020 12:35:24 -0700
Message-Id: <20201019193524.13391-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/edac/amd64_edac.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index fcc08bbf6945..386a3a4cf279 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2461,14 +2461,11 @@ static int map_err_sym_to_channel(int err_sym, int sym_size)
 		case 0x20:
 		case 0x21:
 			return 0;
-			break;
 		case 0x22:
 		case 0x23:
 			return 1;
-			break;
 		default:
 			return err_sym >> 4;
-			break;
 		}
 	/* x8 symbols */
 	else
@@ -2478,17 +2475,12 @@ static int map_err_sym_to_channel(int err_sym, int sym_size)
 			WARN(1, KERN_ERR "Invalid error symbol: 0x%x\n",
 					  err_sym);
 			return -1;
-			break;
-
 		case 0x11:
 			return 0;
-			break;
 		case 0x12:
 			return 1;
-			break;
 		default:
 			return err_sym >> 3;
-			break;
 		}
 	return -1;
 }
-- 
2.18.1

