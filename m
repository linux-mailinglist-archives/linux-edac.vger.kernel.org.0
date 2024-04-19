Return-Path: <linux-edac+bounces-932-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F268AB664
	for <lists+linux-edac@lfdr.de>; Fri, 19 Apr 2024 23:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52EEB1C20923
	for <lists+linux-edac@lfdr.de>; Fri, 19 Apr 2024 21:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500893EA8C;
	Fri, 19 Apr 2024 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="lnA5X4oT"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD26168C4
	for <linux-edac@vger.kernel.org>; Fri, 19 Apr 2024 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713561721; cv=none; b=PE/ze68LJw07KTX+3x4C3e7ELyxBCJ5L5jLRSiAAlMExySdwGzX1+qp47xRrTYXithdLjQJDVY/5he8lrFuHc9MybYJu1uoYD+Wtsni4d+d0p6Yqot7my4Qjjkp7Cu55HJQwj2DC53YkzUnSjSERE74ak1/Rg1bP7Meu0Qxc3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713561721; c=relaxed/simple;
	bh=Dy6r00+QLoVuu1LiYQEFKSZr8Df1mxRid4jJDJgAKAk=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition;
	b=foDetTslSrDUpTHIJXyv0JzBfKGsxIIYqpxWRNn00dZQ7G6i49+6sWUXOlUcnSyva7iJBM6XRMw3GIh6UtIUL7WmymSBWQNqJDiYb9cRBOhR+tM/jl9eQ7TNpxwgHkPRwTaCEcnnLA7XoMXPcRcfAelhE8S1ZM1GyHJkBTJS89c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=lnA5X4oT; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-7d6bc8d4535so98819439f.2
        for <linux-edac@vger.kernel.org>; Fri, 19 Apr 2024 14:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713561718; x=1714166518;
        h=user-agent:content-disposition:message-id:subject:to:from:date
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dk5lXmNBoXbs1sYkD5JKQRQzIZ6XPHZXpN2SFvV8AvY=;
        b=XTNXxujvzAHhgDibT7ghSqqLwO6fuJCuTCf0ExXN+oFUgvNpdsdCpq1OIoDubkGM+p
         PhAwJInE2CjL1e+w+93NOE8LjHKFnHlEjO4p53yo4/uKV5bBIbTcnxdNcOltAcoybtEq
         8b2qlL1DG/cYmGMIhenpzdSQal7apI8coVtQJ9yXLBnZa8rYnc2dqNbNZsCZiN9XGnd0
         km0QCDlsiFseX2dFiAz4ApEkf9YlP9PuqFeWNf6dxukU5hoiXdgJAZh8NgyI8b9djd+Y
         0dzECiwA5LruJBYLlvYhJrZ1hWn3M43DFmIRihbjZjXaU+qtaRYywwvnNOh54FXyyBLp
         hvWg==
X-Forwarded-Encrypted: i=1; AJvYcCW/31xUb0vtjtO6Wm5F/mRTmrguDcV15PbJ+deB6dQgCZy91RWahldzdy0HSbRwtAki8qKX/ioWSFE0bDP01yoJRO/Whai/drR95A==
X-Gm-Message-State: AOJu0Ywf/wU5B30EIUhch4dcsHZZFBY7Hq55eBdLa5YasHajMT1bUR+u
	G4V1ajUtLbdaORre4kjMKGzb7TJ3P0p4v4UHaeKaprPrNl/dzdrPnlQawsxFzaRL4mhkcEUYkAu
	mWfBryOtANC6XxElishAjTbeNV54NJA==
X-Google-Smtp-Source: AGHT+IH06ZnGRvIrfPAfMKjvA86P7UNAIHH3www+B4UrHMIKcqVrdN26RAHJBDiLANSDxR4irHpc6i+aOiwK
X-Received: by 2002:a05:6e02:1a2e:b0:369:9494:5135 with SMTP id g14-20020a056e021a2e00b0036994945135mr3865762ile.24.1713561718482;
        Fri, 19 Apr 2024 14:21:58 -0700 (PDT)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id w12-20020a056e021c8c00b0036a3e54b6c2sm224974ill.59.2024.04.19.14.21.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2024 14:21:58 -0700 (PDT)
X-Relaying-Domain: arista.com
Received: from visor (unknown [172.22.75.75])
	by smtp.aristanetworks.com (Postfix) with ESMTPS id 812AC402054;
	Fri, 19 Apr 2024 14:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1713561717;
	bh=Dk5lXmNBoXbs1sYkD5JKQRQzIZ6XPHZXpN2SFvV8AvY=;
	h=Date:From:To:Subject:From;
	b=lnA5X4oTa+3K6pUwdCVVa/BFXFw6dMlkN2d9/9Bf8kZIcel5Rh23eKoGFXOKknvU9
	 cife91FG1h70sySYbBTPlyDIpW+m0cQ/MN1UI0AsqCGIZnpSRArT8CvkEy6OYDMWwk
	 GuM4FA7S+iilPpTf1lRjujo7bjd0QBLLC1pntj60IpKeYF1+Odqn+Tey1xGWUwqQQJ
	 pLnSsmx7bro9xOPopDvXId4pDP5qiBBZQiaZGvcRgHgJQkuwW7eYv1FYJWdQHH7BKQ
	 KVJDtrx9+rM+Yo0bK7tqXqnw/hMxGcwZWC++OnR/hAtSj4ckqrBlHUPf43hPSHo/qJ
	 VbZUt19GTh17A==
Date: Fri, 19 Apr 2024 14:21:51 -0700
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Ivan Delalande <colona@arista.com>
To: mchehab@kernel.org, linux-edac@vger.kernel.org
Subject: [PATCH] rasdaemon: don't emit error syslog when exiting normally
Message-ID: <20240419212151.GA98667@visor>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Tidy up read_ras_event_all_cpus exit path so that it returns 0 when
exiting normally after receiving a signal. It would return -1 and make
the caller emit "Huh! something got wrong. Aborting." in this case.

Also add missing error message for ras_mc_event_opendb and fix the
grammar a bit in the message above.

Fixes: a7b6a0464fba ("rasdaemon: add signal handling for the cleanup")
Signed-off-by: Ivan Delalande <colona@arista.com>
---
 ras-events.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/ras-events.c b/ras-events.c
index a097238..200163a 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -430,7 +430,7 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 	sigset_t mask;
 	int warnonce[n_cpus];
 	char pipe_raw[PATH_MAX];
-	int legacy_kernel = 0;
+	int rc = 0;
 #if 0
 	int need_sleep = 0;
 #endif
@@ -473,6 +473,7 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 		fds[i].fd = open_trace(pdata[0].ras, pipe_raw, O_RDONLY);
 		if (fds[i].fd < 0) {
 			log(TERM, LOG_ERR, "Can't open trace_pipe_raw\n");
+			rc = -1;
 			goto error;
 		}
 	}
@@ -488,13 +489,17 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 	fds[n_cpus].fd = signalfd(-1, &mask, 0);
 	if (fds[n_cpus].fd < 0) {
 		log(TERM, LOG_WARNING, "signalfd\n");
+		rc = -1;
 		goto error;
 	}
 
 	log(TERM, LOG_INFO, "Listening to events for cpus 0 to %d\n", n_cpus - 1);
 	if (pdata[0].ras->record_events) {
-		if (ras_mc_event_opendb(pdata[0].cpu, pdata[0].ras))
+		if (ras_mc_event_opendb(pdata[0].cpu, pdata[0].ras)) {
+			log(TERM, LOG_ERR, "Can't open database\n");
+			rc = -1;
 			goto error;
+		}
 #ifdef HAVE_NON_STANDARD
 		if (ras_ns_add_vendor_tables(pdata[0].ras))
 			log(TERM, LOG_ERR, "Can't add vendor table\n");
@@ -577,7 +582,7 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 		 */
 		if (count_nready == n_cpus) {
 			/* Should only happen with legacy kernels */
-			legacy_kernel = 1;
+			rc = -255;
 			break;
 		}
 #endif
@@ -605,10 +610,7 @@ error:
 			close(fds[i].fd);
 	}
 
-	if (legacy_kernel)
-		return -255;
-	else
-		return -1;
+	return rc;
 }
 
 static int read_ras_event(int fd,
@@ -1162,7 +1164,8 @@ int handle_ras_events(int record_events)
 		pthread_mutex_destroy(&ras->db_lock);
 	}
 
-	log(SYSLOG, LOG_INFO, "Huh! something got wrong. Aborting.\n");
+	if (rc)
+		log(SYSLOG, LOG_INFO, "Huh! something went wrong. Aborting.\n");
 
 err:
 	if (data)
-- 
2.34.1

