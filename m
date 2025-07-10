Return-Path: <linux-edac+bounces-4339-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA2BAFF6A2
	for <lists+linux-edac@lfdr.de>; Thu, 10 Jul 2025 04:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33BE544393
	for <lists+linux-edac@lfdr.de>; Thu, 10 Jul 2025 02:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DC619D065;
	Thu, 10 Jul 2025 02:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6dsZFjE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87517A944;
	Thu, 10 Jul 2025 02:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752113735; cv=none; b=E6BVwhVgNXIeX4WkxtSPIFLEh8CskFTuhASgDFzVcT/7dcV9vXDiJlCjUmWRUj2iHKEGjHInoP4hGty9Krh7NkrQGJs3XmyoHdL/WRoRSmsuaMEoi/lvkin9eK9Inr1fNJ+6QNnFayGMvkquduxo51EoDzBGzSuscdmQzwA1RjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752113735; c=relaxed/simple;
	bh=aJF9Sq4qL9z3KydcasTITDdgc6lO4iaKDIcFCqTpz8s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jP1RtblAJKN6L5kWT8qULhBJ7slzRWJzVqqP22I+4S6Xs0Fh8G2/48KFTJzDWeADBjN2izQo2ffOTLVn2ECHVnmlVpMjWdlVfVvq59i3u0ib4jRs6u3PbXQTo13yJgOMgLdY9R2i4nqnf5wQBJFST7myXG0Xd5W11sIVnUIGuR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6dsZFjE; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a6f3f88613so5122661cf.1;
        Wed, 09 Jul 2025 19:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752113732; x=1752718532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NdZVUq25CvDB69OnkCN1Siez2qx/clpUZXCX1PPUIb4=;
        b=I6dsZFjEU16wBl+BMVAcGt8vyXJ6k3dFXNfGyWVQYPmlIrAkF9IcAy+Pa9aOXgVCys
         hVjYzYXRnxE7bDKceMgZtuNDPIlRelUaQvLicoe/BBSsQCPHlBlYlrD6oitulc3YzVmQ
         CV20AtbG82mQm5AebnFywDFBo0/b31kQNqte4pQvXKjoObxLtIrk8GFsPQ15u57Rgccx
         T/5WTF+IbvcMBVY8VjNksYqI13T0NhkdEYQ+J+x8BZKO2bOrpI2HpavnXxGnZRKgeslE
         fxVYaoGC+G+EzQoLA+XC+66aybukFc2vmr9vHDsIDGF5NpCZmq5Uc1f6JFHkhciS6bMe
         5w7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752113732; x=1752718532;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NdZVUq25CvDB69OnkCN1Siez2qx/clpUZXCX1PPUIb4=;
        b=s433IYKF9FLIH38u+mDcGTobrxJzft5B0qbew1fAHDzmdbxyHSFXLGewj5pkRP89Zy
         sF0zGaqZrG8dY2DAsfFtdcKKH7O1vUeVL7rwZylV9no2xR27JXZ8h5L95/HiIGUXhInO
         0lWap5MxgoVBcc0IOo4a/IJ+squiMrXNAFITWhyKV7DeVqMNIp+I5FZZ3bPCjOwj5CQI
         Hpfs7fjQsdE/eYezOU3+Bbil2yENJJPl7HDEgDYVo8DzqnypNPRf2jIzz9lHCPPpXaOQ
         J2i0avZsbzoVgW687GPNSZxWAZ83dyliWAp/QjUNLYUR2HgAq66kfBnmGUx+4cuWQVoj
         6gQg==
X-Forwarded-Encrypted: i=1; AJvYcCW80tFzP1KwHszn2EuJaylGT7ANZ/e2TBlQ40zj2j4dvYYT8UujM4JpM8H+B6ZIdzifltT4e0CAlC/2Y4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+L1RctmaCoO7AkNMGHLyopaHMH7CMoTFWgUrESpFGJfLLtWL+
	mCw4iTqDnnUlSmWrMuA8RTNcrmb3ZYyzfCysauol3nrJYpkbV/VhfUpM9fstJzgvtNl5A433VmG
	uw6fk3gAsLehaqfggOguVRWPxutbQXRFuXpd4QSsHWw==
X-Gm-Gg: ASbGnctNsikjVPbiOfDq4kT7mai/bI9jfYCB6jMwJJ78bBxiQUnFkty4YMiZ8lOYehw
	WwukttedyBSBREH6dAwo0QVN6goL66L4jTR/S0U2YPmiXM20gnft2xl6F3pAYfgPz5Hja60xYAU
	1Ylnz3m8GVehiIUHx1ONTmW+1AwcD7VuRxSYJgKnUB8EQ3L71sOTHm24aRnzEusfUUzMQg8/nEx
	e05fQ==
X-Google-Smtp-Source: AGHT+IEHTgEb3q219zK2MlVfoK/zYxdMvtt5jpr1y0SndTWyDXH5Ih4iIyg3CCE78AcyyIJNi7xTI6rZZrYL5mbCbY4=
X-Received: by 2002:a05:622a:1802:b0:476:95dd:520e with SMTP id
 d75a77b69052e-4a9ec74b18cmr20307621cf.16.1752113732264; Wed, 09 Jul 2025
 19:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Wang Haoran <haoranwangsec@gmail.com>
Date: Thu, 10 Jul 2025 10:15:19 +0800
X-Gm-Features: Ac12FXwP7k3B20nSGClcg1Z_QPA541wm7fmHQxxuLFiq33CiX8WHTPmnOljfbRk
Message-ID: <CANZ3JQTpr1xRwc9GED7aXePsZE_KZ6GnpO+wMn2UaMrD4tbMzg@mail.gmail.com>
Subject: We found a bug in skx_common.c for the latest linux
To: tony.luck@intel.com, bp@alien8.de
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, my name is Wang Haoran. We found a bug in the skx_mce_output_error
function located in drivers/edac/skx_common.c in the latest Linux
kernel (version 6.15.5).
The issue arises from the use of snprintf to write into the buffer
skx_msg, which is allocated with size MSG_SIZE.The function formats
multiple strings into skx_msg, including the dynamically generated
adxl_msg, which is also allocated with MSG_SIZE. When combined with
the format string "%s%s err_code:0x%04x:0x%04x %s", the total output
length may exceed MSG_SIZE.
As a result, the return value of snprintf may be greater than the
actual buffer size, which can lead to truncation issues or cause the
skx_show_retry_rd_err_log() function to fail unexpectedly.
Replacing snprintf with scnprintf ensures the return value never
exceeds the specified buffer size, preventing such issues.

--- skx_common.c 2025-07-06 17:04:26.000000000 +0800
+++ skx_common.c 2025-07-09 17:16:56.912779591 +0800
@@ -670,12 +670,12 @@
  }

  if (res->decoded_by_adxl) {
- len = snprintf(skx_msg, MSG_SIZE, "%s%s err_code:0x%04x:0x%04x %s",
+ len = scnprintf(skx_msg, MSG_SIZE, "%s%s err_code:0x%04x:0x%04x %s",
  overflow ? " OVERFLOW" : "",
  (uncorrected_error && recoverable) ? " recoverable" : "",
  mscod, errcode, adxl_msg);
  } else {
- len = snprintf(skx_msg, MSG_SIZE,
+ len = scnprintf(skx_msg, MSG_SIZE,
  "%s%s err_code:0x%04x:0x%04x ProcessorSocketId:0x%x
MemoryControllerId:0x%x PhysicalRankId:0x%x Row:0x%x Column:0x%x
Bank:0x%x BankGroup:0x%x",
  overflow ? " OVERFLOW" : "",
  (uncorrected_error && recoverable) ? " recoverable" : "",

Best regards,
Wang Haoran

